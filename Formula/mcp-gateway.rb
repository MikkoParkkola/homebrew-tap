class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.0.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.2/mcp-gateway-darwin-arm64"
      sha256 "28fcb861b8288e52ecc5a5c437677bb0ec5a1e27d10450abcde92ecc348a534e"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.2/mcp-gateway-darwin-x86_64"
      sha256 "f0b887d776c7f28a0865b47154284de0d5444287a67540a69e2a437b830c8f8b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.2/mcp-gateway-linux-aarch64"
      sha256 "6647350666b98a7482c5a32a6662ace6ae0cda8fa5486cf7e0fe9099fea9cf1c"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.0.2/mcp-gateway-linux-x86_64"
      sha256 "52646434eb0c65dac4954111b5ad8f616c5b4c0a5d8176ed9758199e613ee988"
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
