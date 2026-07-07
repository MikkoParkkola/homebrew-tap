class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.1.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.4/mcp-gateway-darwin-arm64"
      sha256 "e51c7212d625b8bd33f294251a32ffbc2686c6ba7fb1ba9d77039fb25cfc062f"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.4/mcp-gateway-darwin-x86_64"
      sha256 "1869bec52c81cb9b9546ab69c6b385d51f52c1ff731726047b52c4702d008112"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.4/mcp-gateway-linux-aarch64"
      sha256 "a643fcd71fa8b253a3b2994f43f459147c0a049bed3217d731b14b6f02ff4e00"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.1.4/mcp-gateway-linux-x86_64"
      sha256 "ac10116cbdc0123ac6cfb55c54b507cb10589fa1b54acf8406f46fa591e08737"
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
