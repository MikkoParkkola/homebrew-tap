class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.12.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.0/mcp-gateway-darwin-arm64"
      sha256 "10df6345b10ce9911708b800056952a5e8b08c9919f0804eea6171aa10826d77"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.0/mcp-gateway-darwin-x86_64"
      sha256 "595d896a643eda4ac29b92bcd8f7dfe2d76c85b9e64dba951705dcc30cda8326"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.0/mcp-gateway-linux-aarch64"
      sha256 "5b582cef8ca9de1f15cd84e98e7dd9d75771179a49df8321ee4dcd62cbd58e4d"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.0/mcp-gateway-linux-x86_64"
      sha256 "0e3ca10b9255c72a922aa19676f02758a19c363776a3d30730c0b84b000c6b19"
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
