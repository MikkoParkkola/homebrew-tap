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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.23.0/trvl_1.23.0_darwin_amd64.tar.gz"
      sha256 "2fe32fbadaab964496a9bb8607e6c821dcce3142d6ec6abf67b171c20dc40a86"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.23.0/trvl_1.23.0_darwin_arm64.tar.gz"
      sha256 "ab82354c828223d820437f52c7eca7cda4399d6794040d54b67777880396dcca"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.23.0/trvl_1.23.0_linux_amd64.tar.gz"
      sha256 "ee9f50973f38b02837bd787b58dd42b3ceb893ed2bd69af63bc0edfd99dc18de"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.23.0/trvl_1.23.0_linux_arm64.tar.gz"
      sha256 "6d7c0277fe57ff38372d71ee9095ec37645dd6c0dcdb213ac952d40c6920c761"
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
