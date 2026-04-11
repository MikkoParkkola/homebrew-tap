class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.9.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.9.1/mcp-gateway-darwin-arm64"
      sha256 "ddc26345e541a983210a919fd2769abbe99a0e7a61e97ab569d05514a8a0998e"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.9.1/mcp-gateway-darwin-x86_64"
      sha256 "7a3608773494a84dc7bf0bc5de67e794987746e91e91ebc8c7bc8481ad6abbf0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.9.1/mcp-gateway-linux-aarch64"
      sha256 "68998f3dedbf01dfa6a39f379550e33fc6ebbdd658034a52f199549899878503"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.9.1/mcp-gateway-linux-x86_64"
      sha256 "64d4ac7628dfa8b1453f4dfccc482092c13da276eca1e57845d82f6fd5f380ad"
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

  test do
    assert_match "mcp-gateway", shell_output("#{bin}/mcp-gateway --version")
  end
end
