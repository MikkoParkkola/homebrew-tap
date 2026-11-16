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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.1/trvl_1.28.1_darwin_amd64.tar.gz"
      sha256 "b52472c78ec85662ddc4bf63d51a061679f9da8a30b61651219389795661feba"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.1/trvl_1.28.1_darwin_arm64.tar.gz"
      sha256 "c4b35e356b58adb22483badef56d3f995e0902de2c5ded303827c51e5450b1f7"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.1/trvl_1.28.1_linux_amd64.tar.gz"
      sha256 "44a24c3cde67732b52cd53e4af69db037875394c2adc014070f4d0bc9fade848"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.1/trvl_1.28.1_linux_arm64.tar.gz"
      sha256 "ff5a9a6a683f1248bdd1ea559be64c54d40e49279e424e68fc03f5959b196bb5"
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
