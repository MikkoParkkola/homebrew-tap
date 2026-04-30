class Stack < Formula
  desc "Sovereign AI stack — one command installs mcp-gateway, hebb, nab, axterminator, and trvl"
  homepage "https://github.com/MikkoParkkola/homebrew-tap"
  version "1.0.0"
  license "MIT"

  # Metapackage — depends on the four public tools in the sovereign stack.
  # hebb is not yet available via Homebrew (pending public release).
  # Installing this formula pulls every available dependency via Homebrew.
  depends_on "MikkoParkkola/tap/mcp-gateway"
  depends_on "MikkoParkkola/tap/nab"
  depends_on "MikkoParkkola/tap/trvl"

  # axterminator is macOS-only
  depends_on "MikkoParkkola/tap/axterminator" if OS.mac?

  # Shell-based, no arch-specific binary. Bump revision if the setup
  # script changes; Homebrew's bottle logic sees a nil url and skips
  # arch detection for header-only / metapackage formulae.
  url "https://raw.githubusercontent.com/MikkoParkkola/homebrew-tap/v#{version}/stack-setup"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  def install
    bin.install "stack-setup" => "stack-setup"
  end

  def post_install
    return if OS.linux? # axterminator not available
    system "xattr", "-dr", "com.apple.quarantine", "#{bin}/stack-setup"
  rescue
    nil
  end

  def caveats
    <<~EOS
      The sovereign stack is installed! Next step:

        stack-setup

      This auto-detects your AI client (Claude Desktop, Claude Code, Cursor,
      Windsurf, Codex, VS Code, Zed) and wires all five MCP servers.
      Then restart your client.
    EOS
  end

  test do
    assert_match "stack-setup", shell_output("#{bin}/stack-setup --help")
  end
end
