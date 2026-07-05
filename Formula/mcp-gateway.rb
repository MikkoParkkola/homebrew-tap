class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.1/mcp-gateway-darwin-arm64"
      sha256 "56fd1d9e6ebbf44b4a1e26c38cebc94f7d90b85b056758f4375b71f5334f8b42"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.1/mcp-gateway-darwin-x86_64"
      sha256 "191d982f96ee43c7db4fb9e44d9079613e553c1043dfedd7e2e0dfee6870ca47"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.1/mcp-gateway-linux-aarch64"
      sha256 "4cc082098fa34b8bebbabaf6120f88eea438a61ca8de66072f4176009c3e3721"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.1/mcp-gateway-linux-x86_64"
      sha256 "1da7cc2223c15636c26fab0bfa5c838a08286a92733e6818e0f580982c427c72"
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
