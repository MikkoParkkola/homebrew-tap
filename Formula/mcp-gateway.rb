class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.12.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.1/mcp-gateway-darwin-arm64"
      sha256 "4334ef1694e0a3903fa436684b55568a869b3b269b9356ac774d411ba4095155"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.1/mcp-gateway-darwin-x86_64"
      sha256 "bfc35e886d2b6115f0360c5cdb704fc062c0ebe9c14ddad3ac1ed3d8c502bd63"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.1/mcp-gateway-linux-aarch64"
      sha256 "63e533594ebbce9e20def11a900eb62192d2262c9b06dc6510a7efc528ff039b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.1/mcp-gateway-linux-x86_64"
      sha256 "efb3b16b703387bb2ebaac8980e5918c83496456378e56b9f2909cc2447e811b"
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
