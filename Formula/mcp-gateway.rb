class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.2.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.0/mcp-gateway-darwin-arm64"
      sha256 "503e6dc1322d0112cfe93ad5d735af5924d70b7c549852349917256d5d0b0131"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.0/mcp-gateway-darwin-x86_64"
      sha256 "8496c747a846871ff3d7afbd1c2e44140fda34a780f5e682156d920630c85f1b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.0/mcp-gateway-linux-aarch64"
      sha256 "8ecb618a5ca29b519391d89f5d328e92d346a65da347a203d3481f8699f1be07"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.0/mcp-gateway-linux-x86_64"
      sha256 "2c63f3e34bee46b59bc6d689dc861f9fe681e4f22885c2650455689d096bb10e"
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
