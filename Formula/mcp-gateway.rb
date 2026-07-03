class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.0.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.0/mcp-gateway-darwin-arm64"
      sha256 "3297d5f92c8dac5474a6eae2e5cd62986658487f6c795f3ea9cf007e39de9b71"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.0/mcp-gateway-darwin-x86_64"
      sha256 "6fd85c752d40045e6ffa89360006ebf763827f8c7689ec1bd57b75bfd60a5589"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.0/mcp-gateway-linux-aarch64"
      sha256 "4993a1e3e033792a1f4189617f9b980186889faef065d6ceae00aa919fc0ddf6"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.0/mcp-gateway-linux-x86_64"
      sha256 "340fdd10a204fd1351362b09134691d5e8051d3f8bc1e510527894d9a5508d7f"
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
