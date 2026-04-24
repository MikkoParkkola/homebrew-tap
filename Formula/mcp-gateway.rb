class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.10.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.10.1/mcp-gateway-darwin-arm64"
      sha256 "c729adf6586ee4a7e6a94692cecbfa035b65087b34484b3747161af4e67625e6"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.10.1/mcp-gateway-darwin-x86_64"
      sha256 "def76c931cd1ea88dfcba1d5b77f719530c1dd0053f644c78fcedc2f7d188abd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.10.1/mcp-gateway-linux-aarch64"
      sha256 "8a35b4663d1ba6ef94dc251dad5fe0b78f636a0ce9275f9c4343d57156fa2e3b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.10.1/mcp-gateway-linux-x86_64"
      sha256 "5799d575daad4d366a0e6f4584ea04b0756b80407b55ade2d0e63b43cf15e19d"
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
