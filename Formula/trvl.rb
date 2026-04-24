# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.0.7"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.0.7/trvl_1.0.7_darwin_amd64.tar.gz"
      sha256 "e1a757ef6a1b40eec97662e7c35da33e3633263bf2f6e5b4d46437a2551e9352"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.0.7/trvl_1.0.7_darwin_arm64.tar.gz"
      sha256 "07d246275b6e8c5deb16c050c83f720a0254df9b5fc8deaff89b55ab9ca53b06"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.0.7/trvl_1.0.7_linux_amd64.tar.gz"
      sha256 "07d8955c7ebca2de453ed1aaf19f2e08d216cee5ca3507f3474919c525da6e55"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.0.7/trvl_1.0.7_linux_arm64.tar.gz"
      sha256 "701377021704bd532af4525b732595badecba3282537d47b45edb5a29c3c0336"
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
