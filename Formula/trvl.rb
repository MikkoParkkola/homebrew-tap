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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.4/trvl_1.28.4_darwin_amd64.tar.gz"
      sha256 "00d8fd143019abc96d74c0c40fad6232826c13d33243a97373344249d84445f7"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.4/trvl_1.28.4_darwin_arm64.tar.gz"
      sha256 "eb368fb1f976de97bdb803a9fcac64b9ae402dd75c010bf598ce06e71027e2d1"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.4/trvl_1.28.4_linux_amd64.tar.gz"
      sha256 "4164140cb64f0aa1d184453a5714d3c954109c9b87bf09aac06af47c20bfe370"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.4/trvl_1.28.4_linux_arm64.tar.gz"
      sha256 "9bc8abfe9a6ffb75236f44ca1fc2f94e5837e835b0571eb03cd58b5a2dfa8e1d"
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
