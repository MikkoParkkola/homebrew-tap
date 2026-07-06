class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.3/mcp-gateway-darwin-arm64"
      sha256 "b89ce035a289c99581796bcb16978b4a87a4c253cd201b0ee4ce54382a3c1890"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.3/mcp-gateway-darwin-x86_64"
      sha256 "cbdc81d1c3e5db5d6e15d111441378d4fa98f6f6344112efa4de0a8e2f425990"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.3/mcp-gateway-linux-aarch64"
      sha256 "ba89d60f9da847f3a9ce27aeefdc5c78cbd36338e2715d79bea1522c46ae3cbe"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.3/mcp-gateway-linux-x86_64"
      sha256 "51a5c5d539e37a0c315b44909f4207aa04e20cfb1968a1ba67e0defa87012da1"
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
