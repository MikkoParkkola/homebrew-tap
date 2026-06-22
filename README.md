# MikkoParkkola Homebrew Tap

Pre-built command-line tools for macOS and Linux. One command to install,
no `cargo build`, no `go install`, no `sudo`. `axterminator` is currently
macOS-only; the other formulae support both macOS and Linux.

```bash
brew tap MikkoParkkola/tap
brew trust --tap MikkoParkkola/tap   # Homebrew 6.0+
```

You only need to tap once. After that, install any of the formulae below
with a single `brew install` line.

The `brew trust` step is for Homebrew 6.0 and newer, which can require
third-party taps to be trusted before their code runs. It is required if
you have tap trust enabled (`HOMEBREW_REQUIRE_TAP_TRUST`), and harmless to
run otherwise. On older Homebrew versions, skip it.

## What's in here

| Formula | One line |
|---|---|
| [`trvl`](https://github.com/MikkoParkkola/trvl) | AI travel agent — Google Flights, Hotels, ground transport, MCP server, 33 CLI commands |
| [`axterminator`](https://github.com/MikkoParkkola/axterminator) | Background-first macOS GUI automation, MCP server, 30 tools, audio/camera capture |
| [`mcp-gateway`](https://github.com/MikkoParkkola/mcp-gateway) | Universal MCP gateway — single-port multiplexing, ~95% context-token savings |
| [`nab`](https://github.com/MikkoParkkola/nab) | Token-optimized HTTP client for LLMs — fetches any URL as clean markdown |
| [`nowifi`](https://github.com/MikkoParkkola/nowifi) | One-command captive-portal bypass, 43 techniques, restores everything on Ctrl+C |
| **[`stack`](#sovereign-stack)** | **Metapackage — one command installs everything above** |

## One command — the whole stack

```bash
brew tap MikkoParkkola/tap
brew trust --tap MikkoParkkola/tap   # Homebrew 6.0+
brew install MikkoParkkola/tap/stack
stack-setup
```

Installs mcp-gateway, nab, trvl, and axterminator (macOS) in one command.
`stack-setup` auto-detects your AI client and wires all four MCP servers.
Restart your client. Done.

(hebb — the memory server — is coming soon via the same tap.)

## Install individually

```bash
# Travel
brew install MikkoParkkola/tap/trvl

# macOS automation + GUI testing
brew install MikkoParkkola/tap/axterminator

# MCP gateway (one socket for all your MCP servers)
brew install MikkoParkkola/tap/mcp-gateway

# URL → markdown for LLMs
brew install MikkoParkkola/tap/nab

# Captive portal bypass
brew install MikkoParkkola/tap/nowifi
```

Each supported install downloads a pre-built release artifact for your
architecture and finishes in seconds. No build toolchain required.
`axterminator` is currently available as a pre-built formula on macOS only.

## Wire MCP servers into your AI client

After installing, use the automatic setup script:

```bash
stack-setup
```

Or wire individual tools manually:

```bash
trvl mcp install                         # Claude Desktop (default)
trvl mcp install --client cursor         # Cursor
trvl mcp install --client claude-code    # Claude Code
axterminator mcp install                 # Claude Desktop (default)
axterminator mcp install --client claude-code
mcp-gateway setup wizard --configure-client
nab mcp install
```

Then restart your client.

## Update everything

```bash
brew update && brew upgrade
```

## Uninstall

```bash
brew uninstall stack trvl axterminator mcp-gateway nab nowifi
brew untap MikkoParkkola/tap
```

## Contributing / issues

These formulae are mirrors of the canonical sources in each tool's
own repo. Bug reports and feature requests should go to the upstream
repos linked in the table above. Formula bugs (download URL wrong,
checksum mismatch, install fails) belong here.

## License

Each formula is licensed the same way as the tool it installs — see
the `license` line in the `.rb` file. The formulae themselves
(this repo's metadata) are MIT.
