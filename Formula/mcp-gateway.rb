class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.17.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.17.0/mcp-gateway-darwin-arm64"
      sha256 "1b0e602cdab1b3b78660808922a310f631f8d9870885369c530c59855f0bfb47"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.17.0/mcp-gateway-darwin-x86_64"
      sha256 "b50d221d902dbb12d8ae1d1b9a0eff8b223768e56f83e92b507c40ff6a74febc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.17.0/mcp-gateway-linux-aarch64"
      sha256 "838de068793d9ecbcf3492bb48f0d9e464d7f5e0a4abfe0f12fc8eaee05b80b3"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.17.0/mcp-gateway-linux-x86_64"
      sha256 "8779b5c36677e0606e6985b621f189d29025b8f90564a2f82a8e7c0033105f5b"
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
