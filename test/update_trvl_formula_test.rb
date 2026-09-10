# typed: false
# frozen_string_literal: true

require "minitest/autorun"
require "json"
require "fileutils"
require "open3"
require "tmpdir"
require "rbconfig"
require "yaml"

# Maintainer CLI, workflow guard and shipped-formula regression coverage.
class UpdateTrvlFormulaTest < Minitest::Test
  SOURCE_FORMULA = File.expand_path("../Formula/trvl.rb", __dir__).freeze
  SCRIPT = File.expand_path("../scripts/update_trvl_formula.rb", __dir__).freeze
  WORKFLOW = File.expand_path("../.github/workflows/sync-trvl-formula.yml", __dir__).freeze
  JOB = "sync"
  FORMULA_PATH = "Formula/trvl.rb"
  TAP_PATH = "."
  UPDATE_STEP = "Update Formula/trvl.rb"
  PUBLISH_STEP = "Commit formula update"
  PLATFORMS = %w[darwin_amd64 darwin_arm64 linux_amd64 linux_arm64].freeze
  FIXTURE = <<~FORMULA
    class Trvl < Formula
      desc "Fixture metadata must survive"
      license "PolyForm-Noncommercial-1.0.0"
      # Retain this comment and the installation method.
      on_macos do
        on_intel do
          url "https://github.com/MikkoParkkola/trvl/releases/download/v1.20.0/trvl_1.20.0_darwin_amd64.tar.gz"
          sha256 "0000000000000000000000000000000000000000000000000000000000000000"
        end
        on_arm do
          url "https://github.com/MikkoParkkola/trvl/releases/download/v1.20.0/trvl_1.20.0_darwin_arm64.tar.gz"
          sha256 "0000000000000000000000000000000000000000000000000000000000000000"
        end
      end
      on_linux do
        on_intel do
          url "https://github.com/MikkoParkkola/trvl/releases/download/v1.20.0/trvl_1.20.0_linux_amd64.tar.gz"
          sha256 "0000000000000000000000000000000000000000000000000000000000000000"
        end
        on_arm do
          url "https://github.com/MikkoParkkola/trvl/releases/download/v1.20.0/trvl_1.20.0_linux_arm64.tar.gz"
          sha256 "0000000000000000000000000000000000000000000000000000000000000000"
        end
      end
      def install
        bin.install "trvl"
      end
    end
  FORMULA

  def test_updates_urls_and_checksums_in_the_shipped_formula
    Dir.mktmpdir do |dir|
      formula = File.join(dir, "trvl.rb")
      sums = File.join(dir, "checksums.txt")
      FileUtils.cp(SOURCE_FORMULA, formula)
      File.write(sums, checksums("9.9.9"))

      _stdout, stderr, status = Open3.capture3(RbConfig.ruby, SCRIPT, formula, "9.9.9", sums)

      assert status.success?, stderr
      updated = File.read(formula)
      PLATFORMS.each_with_index do |platform, index|
        filename = "trvl_9.9.9_#{platform}.tar.gz"
        assert_includes updated, "/v9.9.9/#{filename}"
        assert_includes updated, %Q(sha256 "#{(index + 1).to_s * 64}")
      end
    end
  end

  # HBT12.UPDATE.1: these inputs do not change when the shipped formula changes.
  def test_normalizes_existing_explicit_version
    input = with_version('  version "1.20.0"')
    assert_includes input, '  version "1.20.0"'
    assert_update(input)
  end

  def test_preserves_url_derived_version
    refute_match(/^[[:space:]]*version[[:space:]]+/, FIXTURE)
    assert_update(FIXTURE)
  end

  # HBT12.UPDATE.2: each input breaks one condition, after three valid platforms.
  def test_missing_fourth_checksum_preserves_every_original_byte
    assert_rejected(FIXTURE, checksums.lines.take(3).join,
                    "missing checksum for trvl_1.21.0_linux_arm64.tar.gz")
  end

  def test_unmatched_fourth_url_preserves_every_original_byte
    input = FIXTURE.sub("1.20.0_linux_arm64.tar.gz", "1.20.0_linux_riscv64.tar.gz")
    assert_rejected(input, checksums, "failed to update linux_arm64 block")
  end

  def test_duplicate_version_preserves_every_original_byte
    input = with_version("  version \"1.20.0\"\n  version \"1.19.0\"")
    assert_includes input, "  version \"1.20.0\"\n  version \"1.19.0\"\n"
    assert_rejected(input, checksums, "multiple version declarations")
  end

  def test_unsupported_version_preserves_every_original_byte
    input = with_version("  version '1.20.0'")
    assert_includes input, "  version '1.20.0'\n"
    assert_rejected(input, checksums, "unsupported version declaration")
  end

  # HBT12.GUARD.3: run the live YAML body without first repairing its input.
  def test_actual_validation_accepts_a_valid_formula
    out, err, status = run_validation(FIXTURE)
    assert status.success?, out + err
  end

  def test_actual_validation_rejects_version_even_before_a_successful_command
    _out, err, status = run_validation(with_version('  version "1.20.0"'))
    refute status.success?
    assert_includes err, "explicit version"
  end

  def test_actual_validation_rejects_wrong_fourth_release_url
    input = FIXTURE.sub("/v1.20.0/trvl_1.20.0_linux_arm64", "/v1.19.0/trvl_1.19.0_linux_arm64")
    _out, _err, status = run_validation(input)
    refute status.success?
  end

  def test_actual_validation_rejects_a_single_quoted_version
    _out, err, status = run_validation(with_version("  version '1.20.0'"))
    refute status.success?
    assert_includes err, "explicit version"
  end

  # Literal portability contract; behavior alone cannot distinguish grep dialects.
  def test_validation_uses_the_reviewed_portable_guard
    body = named_step(workflow_steps, "Validate Homebrew Formula").fetch("run")
    assert_includes body, "grep -Eq '^[[:space:]]*version[[:space:]]+'"
  end

  def test_step_lookup_accepts_one_and_refuses_missing_or_duplicate_names
    step = { "name" => "Validate Homebrew Formula", "run" => "true\n" }
    assert_same step, named_step([step], "Validate Homebrew Formula")
    assert_raises(Minitest::Assertion) { named_step([], "Validate Homebrew Formula") }
    assert_raises(Minitest::Assertion) { named_step([step, step.dup], "Validate Homebrew Formula") }
  end

  def test_validation_precedes_success_gated_publication
    steps = workflow_steps
    update = named_step(steps, UPDATE_STEP)
    validate = named_step(steps, "Validate Homebrew Formula")
    publish = named_step(steps, PUBLISH_STEP)
    assert_operator steps.index(update), :<, steps.index(validate)
    assert_operator steps.index(validate), :<, steps.index(publish)
    [update, validate, publish].each do |step|
      refute step.key?("continue-on-error")
      refute_match(/(?:always|failure|cancelled)\s*\(/, step.fetch("if", ""))
      assert_nil step["if"]
    end
  end

  def test_header_names_both_actual_writers
    formula = File.read(File.expand_path("../Formula/trvl.rb", __dir__))
    refute_match(/^[[:space:]]*version[[:space:]]+/, formula)
    assert_includes formula, "scripts/release/update-homebrew-formula.rb"
    assert_includes formula, "scripts/update_trvl_formula.rb"
    refute_includes formula, "generated by GoReleaser"
    refute_includes formula, "DO NOT EDIT"
  end

  def test_sync_uses_environment_not_expression_interpolation
    names = ["Download trvl release checksums", UPDATE_STEP,
             "Validate Homebrew Formula", PUBLISH_STEP]
    names.each do |name|
      step = named_step(workflow_steps, name)
      assert_equal "${{ steps.version.outputs.version }}", step.fetch("env", {})["VERSION"]
      refute_includes step.fetch("run"), "${{"
    end
  end

  def test_download_receives_one_version_argument
    assert_step_arguments("Download trvl release checksums", { "VERSION" => "1.21.0 candidate *" },
                          [["gh", ["release", "download", "v1.21.0 candidate *",
                                   "--repo", "MikkoParkkola/trvl", "--pattern", "checksums.txt",
                                   "--dir", "dist", "--clobber"]]])
  end

  def test_update_receives_one_version_argument
    calls = assert_step_arguments(UPDATE_STEP, { "VERSION" => "1.21.0 candidate *" },
                                  [["ruby", ["scripts/update_trvl_formula.rb", "Formula/trvl.rb",
                                             "1.21.0 candidate *", "dist/checksums.txt"]]])
    assert_equal 1, calls.length, "Update must only invoke the updater"
  end

  def test_validate_handles_a_version_with_whitespace_and_wildcard
    assert_step_arguments("Validate Homebrew Formula", { "VERSION" => "1.21.0 candidate *" },
                          [["ruby", ["-c", "Formula/trvl.rb"]]])
  end

  def test_commit_preserves_one_message_and_still_calls_push
    calls = assert_step_arguments(PUBLISH_STEP, { "VERSION" => "1.21.0 candidate *" },
                                  [["git", ["commit", "-m", "Update trvl formula to v1.21.0 candidate *"]],
                                   ["git", ["push"]]])
    assert_empty calls.select { |call| %w[ruby gh grep].include?(call.first) },
                 "Commit must not perform Update or Validate again"
  end

  def test_shipped_axterminator_formula_has_the_same_contract_as_its_publisher
    formula = File.read(File.expand_path("../Formula/axterminator.rb", __dir__))
    refute_match(/^[[:space:]]*version[[:space:]]+/, formula)
    assert_includes formula, 'depends_on "rust" => :build'
    assert_includes formula, "depends_on :macos"
    assert_operator formula.index('depends_on "rust"'), :<, formula.index("depends_on :macos")
  end

  private

  def with_version(line)
    FIXTURE.sub("  license \"PolyForm-Noncommercial-1.0.0\"\n",
                "  license \"PolyForm-Noncommercial-1.0.0\"\n#{line}\n")
  end

  def checksums(version = "1.21.0")
    PLATFORMS.each_with_index.map do |platform, index|
      "#{(index + 1).to_s * 64}  trvl_#{version}_#{platform}.tar.gz\n"
    end.join
  end

  def with_files(input, hashes)
    Dir.mktmpdir("homebrew-contract-test-") do |dir|
      formula = File.join(dir, "trvl.rb")
      sums = File.join(dir, "checksums.txt")
      File.write(formula, input)
      File.write(sums, hashes)
      yield formula, sums
    end
  end

  def assert_update(input)
    with_files(input, checksums) do |formula, sums|
      _out, err, status = Open3.capture3(RbConfig.ruby, SCRIPT, formula, "1.21.0", sums)
      assert status.success?, err
      actual = File.read(formula)
      expected = FIXTURE.dup
      PLATFORMS.each_with_index do |platform, index|
        old_url = "https://github.com/MikkoParkkola/trvl/releases/download/v1.20.0/trvl_1.20.0_#{platform}.tar.gz"
        new_url = "https://github.com/MikkoParkkola/trvl/releases/download/v1.21.0/trvl_1.21.0_#{platform}.tar.gz"
        old_pair = %Q(url "#{old_url}"\n      sha256 "#{"0" * 64}")
        new_pair = %Q(url "#{new_url}"\n      sha256 "#{(index + 1).to_s * 64}")
        assert_includes expected, old_pair
        expected.sub!(old_pair, new_pair)
        assert_includes actual, new_pair
      end
      assert_equal expected, actual
    end
  end

  def assert_rejected(input, hashes, diagnostic)
    with_files(input, hashes) do |formula, sums|
      _out, err, status = Open3.capture3(RbConfig.ruby, SCRIPT, formula, "1.21.0", sums)
      assert_equal 1, status.exitstatus
      assert_includes err, diagnostic
      assert_equal input, File.binread(formula)
    end
  end

  def workflow_steps
    YAML.load_file(WORKFLOW).fetch("jobs").fetch(JOB).fetch("steps")
  end

  def named_step(steps, name)
    matches = steps.select { |step| step["name"] == name }
    assert_equal 1, matches.length, "expected exactly one #{name} step"
    matches.first
  end

  def assert_step_arguments(name, environment, expected_calls)
    body = named_step(workflow_steps, name).fetch("run")
    refute_empty body.strip
    Dir.mktmpdir("homebrew-argv-test-") do |dir|
      bin = File.join(dir, "recorders")
      FileUtils.mkdir_p(bin)
      formula = File.join(dir, FORMULA_PATH)
      FileUtils.mkdir_p(File.dirname(formula))
      File.write(formula, FIXTURE.gsub("1.20.0", "1.21.0 candidate *"))
      File.write(File.join(dir, "wildcard-sentinel"), "not a version argument")
      log = File.join(dir, "arguments.jsonl")
      recorder = "#!#{RbConfig.ruby}\n" + <<~RUBY
        require "json"
        name = File.basename($PROGRAM_NAME)
        File.open(ENV.fetch("ARGUMENT_LOG"), "a") { |file| file.puts(JSON.generate([name, ARGV])) }
        exec "/usr/bin/grep", *ARGV if name == "grep"
        exit 1 if name == "git" && ARGV.include?("diff") && ARGV.include?("--quiet")
      RUBY
      %w[git gh ruby grep].each do |command|
        path = File.join(bin, command)
        File.write(path, recorder)
        File.chmod(0755, path)
      end
      shell = File.join(dir, "step.sh")
      File.write(shell, body)
      env = ENV.keys.grep(/^GIT_/).to_h { |key| [key, nil] }
      env.merge!("PATH" => "#{bin}:#{ENV.fetch("PATH")}", "ARGUMENT_LOG" => log,
                 "VERSION" => nil, "RELEASE_TAG" => nil)
      out, err, status = Open3.capture3(env.merge(environment),
                                        "/bin/bash", "--noprofile", "--norc", "-ex", shell, chdir: dir)
      assert status.success?, "#{name}: #{out}#{err}"
      assert File.file?(log), "#{name} must call its command boundary"
      calls = File.readlines(log).map { |line| JSON.parse(line) }
      expected_calls.each { |call| assert_equal 1, calls.count(call), "#{name}: #{calls.inspect}" }
      calls
    end
  end

  def run_validation(input)
    body = named_step(workflow_steps, "Validate Homebrew Formula").fetch("run")
    refute_empty body.strip
    Dir.mktmpdir("homebrew-workflow-test-") do |dir|
      formula = File.join(dir, FORMULA_PATH)
      FileUtils.mkdir_p(File.dirname(formula))
      File.write(formula, FIXTURE)
      git_env = ENV.keys.grep(/^GIT_/).to_h { |key| [key, nil] }
      git_env["GIT_CONFIG_GLOBAL"] = File::NULL
      git_env["GIT_CONFIG_SYSTEM"] = File::NULL
      _out, err, status = Open3.capture3(git_env, "git", "init", "-q", File.join(dir, TAP_PATH))
      assert status.success?, err
      _out, err, status = Open3.capture3(git_env, "git", "-C", File.join(dir, TAP_PATH),
                                         "add", "Formula/trvl.rb")
      assert status.success?, err
      File.write(formula, input)
      shell = File.join(dir, "validate.sh")
      File.write(shell, "#{body}\ntrue\n")
      result = Open3.capture3(git_env.merge("VERSION" => "1.20.0", "RELEASE_TAG" => "v1.20.0"),
                              "/bin/bash", "--noprofile", "--norc", "-e", shell, chdir: dir)
      assert_equal input, File.binread(formula), "validation must not repair its fixture"
      result
    end
  end
end
