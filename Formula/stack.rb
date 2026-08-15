class Stack < Formula
  desc "Sovereign AI stack metapackage"
  homepage "https://github.com/MikkoParkkola/homebrew-tap"
  url "https://raw.githubusercontent.com/MikkoParkkola/homebrew-tap/ab392337077fa8b0316b6fc7125fafab41d9d732/stack-setup"
  version "1.0.0"
  sha256 "c737a7efbf2472c21f04b91460aa1c8eacaa158b8887ad4f385a4dccea697732"
  license "MIT"

  # Metapackage — depends on the four public tools in the sovereign stack.
  # hebb is not yet available via Homebrew (pending public release).
  # Installing this formula pulls every available dependency via Homebrew.
  depends_on "axterminator" if OS.mac?
  depends_on "mcp-gateway"
  depends_on "nab"
  depends_on "trvl"

  # Shell-based, no arch-specific binary. Bump revision if the setup
  # script changes; Homebrew's bottle logic sees a nil url and skips
  # arch detection for header-only / metapackage formulae.

  def install
    bin.install "stack-setup" => "stack-setup"
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
