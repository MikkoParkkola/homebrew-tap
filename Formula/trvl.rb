# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.2.0"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.2.0/trvl_1.2.0_darwin_amd64.tar.gz"
      sha256 "192609c03b2fb12870da938b7a36c9ade89fafd5b1c7a26753e6aa156831c232"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.2.0/trvl_1.2.0_darwin_arm64.tar.gz"
      sha256 "7bb89e27fb2c287c5bd4a4e60b55b114b31273047923400fd89d5083b3339b39"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.2.0/trvl_1.2.0_linux_amd64.tar.gz"
      sha256 "ec34ead21500a615fa7b5d2ac10138f1ec16bcdae084e7af1adb8402a78650ad"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.2.0/trvl_1.2.0_linux_arm64.tar.gz"
      sha256 "ac94e080a25b26970ec60aeee49adfc27b8cf35a4137b599115e4d1de766e6e1"
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
