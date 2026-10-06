# typed: false
# frozen_string_literal: true

# Updated by TRVL's scripts/release/update-homebrew-formula.rb and this tap's
# scripts/update_trvl_formula.rb. Versions are inferred from the release URLs.
class Trvl < Formula
  desc "AI travel agent: flights, hotels and transport via MCP, no API keys"
  homepage "https://github.com/MikkoParkkola/trvl"
  license "PolyForm-Noncommercial-1.0.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.26.0/trvl_1.26.0_darwin_amd64.tar.gz"
      sha256 "00c90f46659a970ccf399b1a72153d370c8db7b1adae56bc2759eaae68886eda"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.26.0/trvl_1.26.0_darwin_arm64.tar.gz"
      sha256 "127ef8d4a80ea213acf354e9b5a72ce266e9f8e18e09083a32875abb768306e3"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.26.0/trvl_1.26.0_linux_amd64.tar.gz"
      sha256 "f3e10ce444d54b387f340b5b7dc70f0cf68dc3d2a2a5a4a2e8781631cf4961c2"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.26.0/trvl_1.26.0_linux_arm64.tar.gz"
      sha256 "bf89c76fc81f26ffd86ef6a8c27b70f6669a678da90971bb1aa5d27532419e00"
      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  def caveats
    <<~EOS
      Run `trvl mcp install` to connect trvl to Claude Desktop, Cursor,
      Windsurf, Codex, VS Code Copilot, Zed, or another MCP client.
    EOS
  end

  test do
    system bin/"trvl", "version"
  end
end
