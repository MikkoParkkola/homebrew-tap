# typed: false
# frozen_string_literal: true

class Trvl < Formula
  desc "Google Flights + Hotels from your terminal — MCP server, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  version "1.1.4"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.4/trvl_1.1.4_darwin_amd64.tar.gz"
      sha256 "956396202e3fad2f7cf976d74158c69d4604380d377b250c8a9ed8f8b810c44f"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.4/trvl_1.1.4_darwin_arm64.tar.gz"
      sha256 "1eaeda992971ade30e9eb7aa0d64216dfd2acd889284a09323ace5b14caac7ad"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.4/trvl_1.1.4_linux_amd64.tar.gz"
      sha256 "99ffe0dd4b9a253f2e7030a487f5408d5711f32ae255c2f329a0c360fa09b689"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.1.4/trvl_1.1.4_linux_arm64.tar.gz"
      sha256 "7af804f949c57d67b40397853b107955f58cd64154f706d2f5b8f6d491432cd7"
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
