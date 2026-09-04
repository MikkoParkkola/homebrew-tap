# typed: strict
# frozen_string_literal: true

# Formula for the nowifi CLI binary releases.
class Nowifi < Formula
  desc "WiFi security assessment tool for captive portals and WPA audits"
  homepage "https://github.com/MikkoParkkola/nowifi"
  license "AGPL-3.0-or-later"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.2/nowifi-darwin-arm64.tar.gz"
      sha256 "18bc74cbe66559a12f4908cf0830abbd288cae529670d15e41f9b88b05c01e7b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.2/nowifi-darwin-amd64.tar.gz"
      sha256 "4f0cfaa083b34072505d5295d9b901f8a23850b57a571e7860a57bd427692120"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.2/nowifi-linux-arm64.tar.gz"
      sha256 "7dcf329712509042076c42f818828842c9242869219a77e053441ca967803448"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/nowifi/releases/download/v0.16.2/nowifi-linux-amd64.tar.gz"
      sha256 "e6828662b5ce175d3592ac9a3030b88da0ac81e3178ac283df45d28b0f7ee8f2"
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
