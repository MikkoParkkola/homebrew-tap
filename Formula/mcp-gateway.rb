class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.0/mcp-gateway-darwin-arm64"
      sha256 "b77b6284bf3413c5f9bc861506d5de46de7e64fb65f6be585cbf36fc94e97fce"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.0/mcp-gateway-darwin-x86_64"
      sha256 "8174a331a15ed19e1578a5fae12eaa0e39ef1cc4f15184948002d427886b7525"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.0/mcp-gateway-linux-aarch64"
      sha256 "135af0035899d633e96017039c7370bd59ff9897f16c72609505b758195247c8"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.0/mcp-gateway-linux-x86_64"
      sha256 "2853bd1812049c3981496060e11c6098f98529d9c1bf9b60ffd1332694801da6"
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
