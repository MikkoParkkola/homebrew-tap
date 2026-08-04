# typed: strict
# frozen_string_literal: true

# Formula for the nowifi CLI binary releases.
class Nowifi < Formula
  desc "WiFi security assessment tool for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  version "0.16.1"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.1/nowifi-darwin-arm64.tar.gz"
      sha256 "414ef05132e8d023e9703157cafcb7fd9059c6bb73ac85752bec9a60f3e843d7"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.1/nowifi-darwin-amd64.tar.gz"
      sha256 "e03f7ceeb14c7bd3e6d8bd07393291a48790ef7e2bbd4197dbb6ee9c1a44ae92"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.1/nowifi-linux-arm64.tar.gz"
      sha256 "cab76254db4f2e5d55d4f86a23fce64fcd3e542cc678e0b505920458ac06b4d2"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.1/nowifi-linux-amd64.tar.gz"
      sha256 "bfd6d33c7f11db9ddffd575cb8ea686c74c262683a1e4311a39c5a66916869c6"
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
