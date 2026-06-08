class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.18.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.18.0/mcp-gateway-darwin-arm64"
      sha256 "36fa21a51cddf416fcad1cf5f441470be1c35ef98495d6d4cdad937c625ed1ee"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.18.0/mcp-gateway-darwin-x86_64"
      sha256 "c8884566aaca1e81acaf97913fed2764a82ede04059c090b2a2d8c9b39c197b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.18.0/mcp-gateway-linux-aarch64"
      sha256 "78ecfd169aebb72f5f383323baa990346b890eaaaeb2df74c66919c1901edb17"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.18.0/mcp-gateway-linux-x86_64"
      sha256 "7ecc522a4a140aaa1e612644054abd51b905c3710f5286a9ddcd7b45f630cc93"
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
