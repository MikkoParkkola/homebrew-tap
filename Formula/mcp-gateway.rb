class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.6.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.6.0/mcp-gateway-darwin-arm64"
      sha256 "d0592403f2bf400bd9889770b52d1229b1aa1e31b396ddd58d0e16ddecd059a7"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.6.0/mcp-gateway-darwin-x86_64"
      sha256 "6be769a986f2d4f22e975aa72d5e9ddba490b91b2fd3669ec6bf011d7b75c884"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.6.0/mcp-gateway-linux-x86_64"
      sha256 "e71cc6ad76584ba3675be9fadf8a6df42e2f270791781adcf83163334feb057e"
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
      bin.install "mcp-gateway-linux-x86_64" => "mcp-gateway"
    end
  end

  test do
    assert_match "mcp-gateway", shell_output("#{bin}/mcp-gateway --version")
  end
end
