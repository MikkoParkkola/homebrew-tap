# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.1.1"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.1/trvl_1.1.1_darwin_amd64.tar.gz"
      sha256 "2a9ffafd454a0b8de36657e5a76eb21cf12e7c80109eb4b41acd3fa7eb076529"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.1/trvl_1.1.1_darwin_arm64.tar.gz"
      sha256 "e668f271fa7084798073933c46ea297b29019bed520be4ad5f072f39bdf388a0"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.1/trvl_1.1.1_linux_amd64.tar.gz"
      sha256 "2b5bfd5c5ec974e6f87aa094b229530868886a1b3c07f0f64af683f3c183635d"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.1/trvl_1.1.1_linux_arm64.tar.gz"
      sha256 "0fa64c396fe56638ca07cb21c73100c0ba5deaca619e0306ea0c57ffaa047628"
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
