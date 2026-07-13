class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  version "3.3.1"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.1/mcp-gateway-darwin-arm64"
      sha256 "f90f42ad951020a1a58631c4c39eb31240d8e00316489e63c123a4cbf04327d7"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.1/mcp-gateway-darwin-x86_64"
      sha256 "9f11696121de60ce1c3a1c99d1ff618de4a1ef0ed6243fe06866b3837007b22c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.1/mcp-gateway-linux-aarch64"
      sha256 "b0bd16a8e43a42ee738b512ab6eb7de5d466c84dbdcff2a42f75ea4eb9d61874"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.3.1/mcp-gateway-linux-x86_64"
      sha256 "3d490d8e5139a299db6b975726e4c8c09320f90d1ed3279bf2b7519f4bc5a338"
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
