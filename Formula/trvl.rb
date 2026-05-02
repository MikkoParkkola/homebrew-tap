# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.1.2"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.2/trvl_1.1.2_darwin_amd64.tar.gz"
      sha256 "68bdeb77d4abf11169e8193dea10104fede53e0f911aa44119e224f73281e09f"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.2/trvl_1.1.2_darwin_arm64.tar.gz"
      sha256 "3049818a3a7b3e2e2541e9d74ab558541f8ceabbdf06177bd4ad13a95e3c90e3"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.2/trvl_1.1.2_linux_amd64.tar.gz"
      sha256 "8779645f91125eb22f27e7266e67ec5187f1a628467d43fbb4ff366d6330c2a2"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.2/trvl_1.1.2_linux_arm64.tar.gz"
      sha256 "389f881610a90fa8f6189f35ee889fe9fa9a721aaa97ea1f411a7164565278d6"
      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  def post_install
    system "xattr", "-dr", "com.apple.quarantine", "#{bin}/trvl" if OS.mac?
  rescue
    nil
  end

  test do
    system "#{bin}/trvl", "--help"
  end
end
