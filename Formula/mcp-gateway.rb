class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  # Required because the artifact basename ends in the architecture (arm64/x86_64),
  # which a clean Homebrew install can otherwise mis-detect as the version.
  version "3.5.2"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.2/mcp-gateway-darwin-arm64"
      sha256 "c6d5da083a36bfcfecd46681374e9c8c2060b58fb8561854e596c2039b3e1a7b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.2/mcp-gateway-darwin-x86_64"
      sha256 "f688827de3d999d57f55f17b93f6e64f618d68b0ac92167f4374b0720cea6341"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.2/mcp-gateway-linux-aarch64"
      sha256 "879fc205a14b20afdfa369269eca3c400d3294a0c410e2279a489e595732fc09"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.2/mcp-gateway-linux-x86_64"
      sha256 "f359f3900f14eca674c10c83a6c37808369244a7a5865aded5b642a00ba45dc5"
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
