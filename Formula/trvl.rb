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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.5/trvl_1.28.5_darwin_amd64.tar.gz"
      sha256 "d704abad507cb78610175b8cb65182e3f0f25c3a835cf657774b3370d4d408ee"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.5/trvl_1.28.5_darwin_arm64.tar.gz"
      sha256 "acf120f91d5b13f87bd0d8a45d7672d5559ba07ca07075e67e33792f5a5c473d"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.5/trvl_1.28.5_linux_amd64.tar.gz"
      sha256 "4decaaba9ee1f767b5e1747e2c2852ae6d546ce71d54ddcb9e67a356db446090"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.28.5/trvl_1.28.5_linux_arm64.tar.gz"
      sha256 "8700b433cd7db84a72fc6af109b62b46cbe82930b483d95996fd4d98543c6417"
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
