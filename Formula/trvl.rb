# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.1.3"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.3/trvl_1.1.3_darwin_amd64.tar.gz"
      sha256 "6bd6f239129df44267e210f7dc24c2ba3b1010c614511c464478155e36291a44"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.3/trvl_1.1.3_darwin_arm64.tar.gz"
      sha256 "5d23aa001cfa3fed063bf554eb9f22d9a83753dce34daab6e3210d0c0ecdef4d"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.3/trvl_1.1.3_linux_amd64.tar.gz"
      sha256 "8b87c86e33246b3c39fb36e9fc5b8daf1ace672c9652c58877102b2e7eac2450"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.3/trvl_1.1.3_linux_arm64.tar.gz"
      sha256 "549e198b0b1a5fba61d0efcd6c53f76d66d904d179a4401cb994b66880dac8a5"
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
