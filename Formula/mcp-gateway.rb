class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  # Required because the artifact basename ends in the architecture (arm64/x86_64),
  # which a clean Homebrew install can otherwise mis-detect as the version.
  version "3.5.0"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.0/mcp-gateway-darwin-arm64"
      sha256 "9a860c944506c6e132ace8194c1ff63fd95a0eec4458a86939c6e217e1746d9d"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.0/mcp-gateway-darwin-x86_64"
      sha256 "53c9cd3573a68728a1391c24a48dc5e17c8f2adcce13dd6516fe32fa788f7162"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.0/mcp-gateway-linux-aarch64"
      sha256 "d26deeae74caab471e2d4b53b2999bc7d7453428bcd406cf9feeb33ec960e04b"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.5.0/mcp-gateway-linux-x86_64"
      sha256 "52915aaf6cb7f29a76c2af8af5129e60dd4a9d6c9bcf4e00e0beca7969a3f9eb"
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
