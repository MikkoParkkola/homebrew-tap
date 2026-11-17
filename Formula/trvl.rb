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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.3/trvl_1.28.3_darwin_amd64.tar.gz"
      sha256 "2b35b19ea4a3d00f4584135c393abcd0bc6c7cca36610b8a2bde49a5b3ae6af3"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.3/trvl_1.28.3_darwin_arm64.tar.gz"
      sha256 "03775d590fee668c06380cb3d182719918e3168f5f03a365455bb7452577ffc8"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.3/trvl_1.28.3_linux_amd64.tar.gz"
      sha256 "b6a239e9bba1c04c1f73787eac79a3ae60eb78ed754850b9f5671834c0398b7e"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.3/trvl_1.28.3_linux_arm64.tar.gz"
      sha256 "159d35e965c65cca15a1bb878ee8fb2c29b9f5e0cccb4b6ed8e4f51a709b738f"
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
