class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.19.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.19.0/mcp-gateway-darwin-arm64"
      sha256 "fa403e9c0516b113eedd82f434672167742d166b64df2a31eb0f8b5d31eb8004"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.19.0/mcp-gateway-darwin-x86_64"
      sha256 "ece8da4b983a39fed46957a49144f86fc389c46a76e3c5a8db1a87bdfc6171ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.19.0/mcp-gateway-linux-aarch64"
      sha256 "1cd42c0bfe09f3585984b1dc24c9015cef3fd79098d8ca0c77339fdf8ca2c662"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.19.0/mcp-gateway-linux-x86_64"
      sha256 "220629d2bb7c6a116aad8ea42349a5686cbcf8ffa93e27d9ceb2a2c4fae1d6a5"
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
