class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.3.0"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.0/mcp-gateway-darwin-arm64"
      sha256 "2451aa3546baed963c061cb3fb46d63ae6ca9bc0a63a778a22b5d8e4a0c2c0a1"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.0/mcp-gateway-darwin-x86_64"
      sha256 "e25a3317a324f374fece969e8d48ecbb5d1b97782cfcb7963688e353564c6aca"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.0/mcp-gateway-linux-aarch64"
      sha256 "1d98a4b154d693fbb370461a07d15d4ffd2aad4204bf7d5e4eb66e0bd88e09e0"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.0/mcp-gateway-linux-x86_64"
      sha256 "ed6ce18baccb24a15db3ebf4004ea170c7a4c02149cb3ddfd73832feab16a620"
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

  def caveats
    <<~CAVEATS
      Licensing: mcp-gateway uses mixed, per-file licensing; the runnable
      gateway is PolyForm Noncommercial 1.0.0. Commercial use requires a
      license. See https://github.com/MikkoParkkola/mcp-gateway/blob/main/COMMERCIAL.md
    CAVEATS
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"mcp-gateway"} --version")
  end
end
