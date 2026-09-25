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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.22.0/trvl_1.22.0_darwin_amd64.tar.gz"
      sha256 "94719b46133296b79f93d25859b424be17907e0e3debe0d72f59c01d680f7ffe"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.22.0/trvl_1.22.0_darwin_arm64.tar.gz"
      sha256 "8bccf9779810bd3bff276b83c57a91d8b3d185efafab2e444e0e6e2baec987c6"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.22.0/trvl_1.22.0_linux_amd64.tar.gz"
      sha256 "8361fef5d6c042ba4503abccb0ad213e28e5cdb06823675e6482655a1e6c64c0"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.22.0/trvl_1.22.0_linux_arm64.tar.gz"
      sha256 "f16ed6de7c4113f29f0954879a9398ac3af3cd81682ec601019a018bdfbbef1e"
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
