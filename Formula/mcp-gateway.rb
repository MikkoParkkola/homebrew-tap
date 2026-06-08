class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.15.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.0/mcp-gateway-darwin-arm64"
      sha256 "4c1c75f392216991df8d29008254f98c96bdffc842befa298bfed7dd339b0d43"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.0/mcp-gateway-darwin-x86_64"
      sha256 "eef8eab43828e242c833cac4da99f08af2f4071f8e4052480eca382419935fca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.0/mcp-gateway-linux-aarch64"
      sha256 "ae4a50d683340ee2ded72a0d18d18d196c8dba67be33b79445abffe1551b14dc"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.0/mcp-gateway-linux-x86_64"
      sha256 "9308acbbd0db6fc1ee5ee8d2d7e14798b59ca0099dcfe59a7b031d8a307beffa"
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
