class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.16.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.16.0/mcp-gateway-darwin-arm64"
      sha256 "567c6adc001a143498d693896dd61aa05196b047e0fc68a322236d87db5ed718"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.16.0/mcp-gateway-darwin-x86_64"
      sha256 "dba7b91db8467e2a27b177cdbec5805cae4275917e6788bfd9dcefe43cf20a47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.16.0/mcp-gateway-linux-aarch64"
      sha256 "04989a3acff3e589efaef36a793b1afe0e4cefad36536bec7deaa3d7f03a7b79"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.16.0/mcp-gateway-linux-x86_64"
      sha256 "3ca47c29b64250c6f08481647f5a016092e96ca79f6e332523b220b23339594e"
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
