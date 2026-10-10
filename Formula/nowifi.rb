# typed: strict
# frozen_string_literal: true

# Formula for the nowifi CLI binary releases.
class Nowifi < Formula
  desc "WiFi security assessment tool for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.3/nowifi-darwin-arm64.tar.gz"
      sha256 "2c8848ce2104e3dd3622505ca97fa8c1f6ade6d257282b86c65d7861626f84e5"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.3/nowifi-darwin-amd64.tar.gz"
      sha256 "feeee79a07622b58759670a6f3cb064f269992195cbf3e1fecfa99ca411ad41b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.3/nowifi-linux-arm64.tar.gz"
      sha256 "de4b56526aa1c9ff7e4208de336424084c227e601c786235d12a8f5276b9521e"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.3/nowifi-linux-amd64.tar.gz"
      sha256 "a33feddf7206d28cc4bebafe45078b6ceb30b568ed5d3c8c2858b021747cefce"
    end
  end

  def install
    # Each tarball contains a single bare binary named nowifi-<os>-<arch>.
    # Pick whatever is in the staging dir and install it as bin/nowifi.
    binary = Dir["nowifi-*"].first
    odie "no nowifi binary in tarball" unless binary
    bin.install binary => "nowifi"
  end

  test do
    assert_match "nowifi", shell_output("#{bin}/nowifi --version")
  end
end
