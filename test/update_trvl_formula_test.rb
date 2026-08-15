# frozen_string_literal: true

require "minitest/autorun"
require "fileutils"
require "open3"
require "tmpdir"

class UpdateTrvlFormulaTest < Minitest::Test
  PLATFORMS = %w[darwin_amd64 darwin_arm64 linux_amd64 linux_arm64].freeze
  SCRIPT = File.expand_path("../scripts/update_trvl_formula.rb", __dir__).freeze
  SOURCE_FORMULA = File.expand_path("../Formula/trvl.rb", __dir__).freeze

  def test_updates_url_derived_version_without_adding_explicit_version
    Dir.mktmpdir do |dir|
      formula = File.join(dir, "trvl.rb")
      checksums = File.join(dir, "checksums.txt")
      FileUtils.cp(SOURCE_FORMULA, formula)
      File.write(checksums, checksum_fixture("9.9.9"))

      _stdout, stderr, status = Open3.capture3("ruby", SCRIPT, formula, "9.9.9", checksums)

      assert status.success?, stderr
      updated = File.read(formula)
      refute_match(/^\s*version\s+"/, updated)
      PLATFORMS.each_with_index do |platform, index|
        filename = "trvl_9.9.9_#{platform}.tar.gz"
        assert_includes updated, "/v9.9.9/#{filename}"
        assert_includes updated, %Q(sha256 "#{(index + 1).to_s * 64}")
      end
    end
  end

  private

  def checksum_fixture(version)
    PLATFORMS.each_with_index.map do |platform, index|
      "#{(index + 1).to_s * 64}  trvl_#{version}_#{platform}.tar.gz"
    end.join("\n")
  end
end
