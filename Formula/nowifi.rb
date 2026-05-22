# typed: strict
# frozen_string_literal: true

# Formula for the nowifi CLI binary releases.
class Nowifi < Formula
  desc "WiFi security assessment tool for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  version "0.15.0"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.15.0/nowifi-darwin-arm64.tar.gz"
      sha256 "bbac0d347fb442e46264878732cd2001d425ddf65455ae7f67976edca105a7f2"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.15.0/nowifi-darwin-amd64.tar.gz"
      sha256 "f6b15a51a06a10129507c99fb25d76ef91b0c8017ed7df3e2441e506ce7d3f33"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.15.0/nowifi-linux-arm64.tar.gz"
      sha256 "4c645d61b43e0ca6c29fdf4fc85c4df200f99db3ba3bd5ac6c7846d91af2faf9"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.15.0/nowifi-linux-amd64.tar.gz"
      sha256 "a3b870c42d87d8313c7bc6cb688c316b3bb4ef429c5192184deef3dfc9c3ccb8"
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
