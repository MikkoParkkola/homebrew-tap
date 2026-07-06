class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.2/mcp-gateway-darwin-arm64"
      sha256 "fcae21444a463200353534bca5febf74ada3d3eb92384717be3380f3d516d2b5"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.2/mcp-gateway-darwin-x86_64"
      sha256 "a7348784ddcaeaf4f75acb4704d6db7bcbb9318f77a80125524d18b94f7ef438"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.2/mcp-gateway-linux-aarch64"
      sha256 "f0d56c4b72c7bd0f0925112ca20cb5fac17e9ac093753bbb0410eed5df45cb28"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.2/mcp-gateway-linux-x86_64"
      sha256 "687d941dea39b2c824d1f0861002d4be68113986e4b862b326a7de0a82e7c908"
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
