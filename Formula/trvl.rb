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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.27.0/trvl_1.27.0_darwin_amd64.tar.gz"
      sha256 "fe9c4788aa44d23a379f3275901b403e31350c1f595e216731ad825496e65353"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.27.0/trvl_1.27.0_darwin_arm64.tar.gz"
      sha256 "38ad972cbf293f2259be8f0db8031e4eb56d8e8f3f34cf75bb2d404c3d64df18"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.27.0/trvl_1.27.0_linux_amd64.tar.gz"
      sha256 "dd9b0c5409add5c7ac3efbcc2953c3e09d748f6de7d84fffbe0f8eccb51c9000"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.27.0/trvl_1.27.0_linux_arm64.tar.gz"
      sha256 "10d5160c224a83bd89b6aef951b4000c00a92e318e98dc29fd9119a9c0793857"
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
