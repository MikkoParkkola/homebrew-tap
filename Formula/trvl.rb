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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.24.0/trvl_1.24.0_darwin_amd64.tar.gz"
      sha256 "055247b6eeaa20c5803536bbb0ceb83136e8c9cc471b180a999514bc848e19f0"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.24.0/trvl_1.24.0_darwin_arm64.tar.gz"
      sha256 "0ad50f0d4662b5537ef425e308b60bbc87e0315cd540720cbbcee898d98bd769"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.24.0/trvl_1.24.0_linux_amd64.tar.gz"
      sha256 "a446be247cf1ef82d81e17fbc06bfc9b817afb6512e4e6e8aae59ac54acef745"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.24.0/trvl_1.24.0_linux_arm64.tar.gz"
      sha256 "6f7bbb9523f880a085e0e6cb2cdcbdd34e8a455a68e6703a97d96417236d5433"
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
