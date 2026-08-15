class McpGateway < Formula
  desc "Universal MCP gateway — single port for all your MCP servers, ~95% token savings"
  homepage "https://github.com/MikkoParkkola/mcp-gateway"
  # Required because the artifact basename ends in the architecture (arm64/x86_64),
  # which a clean Homebrew install can otherwise mis-detect as the version.
  version "3.4.0"
  # Mixed, per-file licensing (PolyForm-Noncommercial default + MIT core);
  # SPDX can't express it. See LICENSES.md / COMMERCIAL.md.
  license :cannot_represent

  on_macos do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.4.0/mcp-gateway-darwin-arm64"
      sha256 "cf39eab92d12956d5f224c8410ebca318db05d85c5bf05d06fcddbecc9d4ead6"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.4.0/mcp-gateway-darwin-x86_64"
      sha256 "0671c5a2ca1a27b3999529f439fdd2b4a6136eff440cf09132b1dfba86349a3b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.4.0/mcp-gateway-linux-aarch64"
      sha256 "782fc53baacd6586330f8536364976c0bc17e5329a9a8c080d9ab4a9f93f09db"
    end
    on_intel do
      url "https://github.com/MikkoParkkola/mcp-gateway/releases/download/v3.4.0/mcp-gateway-linux-x86_64"
      sha256 "73bdebddb6c6b14fa702f56260b6e635c583175dec6faf226966b5f15a90846c"
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
