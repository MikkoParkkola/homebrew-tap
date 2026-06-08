class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.14.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.14.0/mcp-gateway-darwin-arm64"
      sha256 "e5f0252db27d68d1d93c40d5420f67feb378ab0ace9fd0835290a1f55429007b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.14.0/mcp-gateway-darwin-x86_64"
      sha256 "46a3da6856b20d1e4b92b48e5434036219e6649e3127639a05a5cb2d023182b2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.14.0/mcp-gateway-linux-aarch64"
      sha256 "2fbf7a23284d1a510361b707171b423d0ae34a9743c896e2dcf9e4f33dc92f64"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.14.0/mcp-gateway-linux-x86_64"
      sha256 "1e655bf7d27644654e1d974fa9d7ea9e8e1a65fba9db8ec336204ea49ba45988"
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
