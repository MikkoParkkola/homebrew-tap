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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.2/trvl_1.28.2_darwin_amd64.tar.gz"
      sha256 "3865e4a66ea4c26ee426c82604867bd98c7f33b9d421fe82d5a3929327ec15bc"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.2/trvl_1.28.2_darwin_arm64.tar.gz"
      sha256 "8ed6df95cabee62b24a89cf1754f4ef4e53ce6755b8b3f52f743fb10ad6e4b05"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.2/trvl_1.28.2_linux_amd64.tar.gz"
      sha256 "b0d64e2a6b3e0b1413ee8ab0484fe1286b311443aa82c6e2a85c1770da2af126"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.2/trvl_1.28.2_linux_arm64.tar.gz"
      sha256 "12d326f9a8240d68882b008078720e66b677c0b654578fe19bfcdf1575b4671c"
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
