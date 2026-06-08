class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.12.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.2/mcp-gateway-darwin-arm64"
      sha256 "baaa503b5e374992569ce66def144e613e3e9c874a265dd696896da543c42366"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.2/mcp-gateway-darwin-x86_64"
      sha256 "b96df8b501a92229d616903c0b08d265e63dc3c4ce67b0e3636f736c5a2d860f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.2/mcp-gateway-linux-aarch64"
      sha256 "4f13b3ab4a585e0900f5acccd9ccc20315852a9553b92031778d62255cfb7d2b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.12.2/mcp-gateway-linux-x86_64"
      sha256 "49b52ecd8197305197fcf41f87fc066157e3e38475ce6e82009693784d09b5a8"
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
