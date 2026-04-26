# typed: strict
# frozen_string_literal: true

# Formula for the nowifi CLI binary releases.
class Nowifi < Formula
  desc "WiFi security assessment tool for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  version "0.14.3"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.3/nowifi-darwin-arm64.tar.gz"
      sha256 "81bf2b82929a0b6e6ae969ee273b3edb35b432e40bed132d56d5836a54f89f95"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.3/nowifi-darwin-amd64.tar.gz"
      sha256 "6956e4e3270c2e94daa1f3d84db1f7c322bcd97046115102456c03938231a501"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.3/nowifi-linux-arm64.tar.gz"
      sha256 "f1885844a501b9f93d071d80c07ffc7cfb2369d88deede62938ef20b271d58ce"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.14.3/nowifi-linux-amd64.tar.gz"
      sha256 "25eb12e3a662ab4dd37fb2c1ce17e504ffa0e5757d5c85a1c7ab1a65a545f4bb"
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
