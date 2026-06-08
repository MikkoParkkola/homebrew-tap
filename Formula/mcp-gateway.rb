class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.15.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.1/mcp-gateway-darwin-arm64"
      sha256 "db2e3b4399a431b0dfe373775e26c01394129bc043d124704bcea44d6fe08293"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.1/mcp-gateway-darwin-x86_64"
      sha256 "4010625aec4f959bad372cbf1b62049a69cfd47219967432bff9713164a1bfd6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.1/mcp-gateway-linux-aarch64"
      sha256 "29692260270e27341b475f64818c32b9c53df6866aac4a9c074341c7a6b269e9"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.15.1/mcp-gateway-linux-x86_64"
      sha256 "e61c1eda78b2396c34d19d56359f7b0e98fa77e60376c3d4c72972691c1a334a"
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
