class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.2.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.1/mcp-gateway-darwin-arm64"
      sha256 "d157271e7f0545d4be0cee0bebd169c7c9ba32b7bdef676da6c0213d77d8a05e"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.1/mcp-gateway-darwin-x86_64"
      sha256 "61b9f8cdf21ca754a08b2fef136e4d750db3749c5f36cd9939da0ff74a486749"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.1/mcp-gateway-linux-aarch64"
      sha256 "51a5ea06b43f26ab5100381d07c24ccfdb13fa58fe3476a4ab8bbfeefdb62f24"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.2.1/mcp-gateway-linux-x86_64"
      sha256 "b46432fdefcea751d685dde08f098f2d6b89e629483c0d30810231700a857534"
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
