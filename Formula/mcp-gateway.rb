class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "2.13.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.13.0/mcp-gateway-darwin-arm64"
      sha256 "d1928e3caab7a42e4c5bba05dad7d528bc7727efc9856868ba473377c3721f2b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.13.0/mcp-gateway-darwin-x86_64"
      sha256 "c306d2de683b69ce8b9890181655d850d9b22c33ba288d232faabc24c553bb08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.13.0/mcp-gateway-linux-aarch64"
      sha256 "1ba05a48a54809d4edac8e2a02bc203abaf1bd228aa507da59cb046072e63457"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v2.13.0/mcp-gateway-linux-x86_64"
      sha256 "942b973f0c710dbd2f7a08440215bfd450715b4663874dc679046c3e1309561f"
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
