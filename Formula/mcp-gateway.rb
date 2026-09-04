class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  # Required because the artifact basename ends in the architecture (arm64/x86_64),
  # which a clean Homebrew install can otherwise mis-detect as the version.
  version "3.5.1"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.1/mcp-gateway-darwin-arm64"
      sha256 "78fc2fdb5a56539a35b9204e704374303f140ed91f933492f92f49acdece77b1"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.1/mcp-gateway-darwin-x86_64"
      sha256 "c7466255249ca5d3119195bff10e64095a39c9ef05066410e5fcf46f6e08f3d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.1/mcp-gateway-linux-aarch64"
      sha256 "76bcc9eb30b4aa7b7740f0c9dfa9e8dcc0d49b38a9e454ab4b48873493cfdc70"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.1/mcp-gateway-linux-x86_64"
      sha256 "198b2d7a134286baeb4b42228436325fdf597c804a9d108fc83b1cb77fe7e157"
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
