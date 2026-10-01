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
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.25.0/trvl_1.25.0_darwin_amd64.tar.gz"
      sha256 "2f941cada96a982954e720ee69617c3b8eb3ed41bee48d54ffdbd450e4a2861e"

      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.25.0/trvl_1.25.0_darwin_arm64.tar.gz"
      sha256 "7c7a676a56716872c4a692dae794d85a2f5e2effad5ca974a128d5661d198a0d"

      define_method(:install) do
        bin.install "trvl"
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.25.0/trvl_1.25.0_linux_amd64.tar.gz"
      sha256 "4dbf081aab3705deda9c14c3621bf37ff696362bd767f8f15ad11ed183d44683"
      define_method(:install) do
        bin.install "trvl"
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/MikkoParkkola/trvl/releases/download/v1.25.0/trvl_1.25.0_linux_arm64.tar.gz"
      sha256 "3cf158fdeb2df060a7aa147467a577b1b71eb31f379a932d7e51a77d9a9aec57"
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
