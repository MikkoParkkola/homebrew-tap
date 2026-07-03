class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.0.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.1/mcp-gateway-darwin-arm64"
      sha256 "e1b439a9078ecb1508a71880df7c194757ae4844108385599eb4fa1d2eeffd37"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.1/mcp-gateway-darwin-x86_64"
      sha256 "84267e2e81a388d6500e6c821740d175f61f55d209170f327d53fe278ab0e911"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.1/mcp-gateway-linux-aarch64"
      sha256 "693ce968fb7c79aa0d63ab7438bb92f7677f09c0f5f642420697dcf2596c4f6a"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.1/mcp-gateway-linux-x86_64"
      sha256 "3812edc83d0d612851188b4305395c4591f441cb302a7e1bbd05ca4cb4bb8aad"
    end
  end

  def install
    if OS.mac?
      if Hardware::CPU.arm?
        bin.install "mcp-gateway-darwin-arm64" => "mcp-gateway"
      else
        bin.install "mcp-gateway-darwin-x86_64" => "mcp-gateway"
      end
    elsif OS.linux?
      if Hardware::CPU.arm?
        bin.install "mcp-gateway-linux-aarch64" => "mcp-gateway"
      else
        bin.install "mcp-gateway-linux-x86_64" => "mcp-gateway"
      end
    end
  end

  def post_install
    system "xattr", "-dr", "com.apple.quarantine", "#{bin}/mcp-gateway" if OS.mac?
  rescue
    nil
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"mcp-gateway"} --version")
  end
end
