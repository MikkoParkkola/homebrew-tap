# MikkoParkkola Homebrew Tap

Pre-built command-line tools for macOS and Linux. One command to install,
no toolchains, no `cargo build`, no `go install`, no `sudo`.

```bash
brew tap MikkoParkkola/tap
```

You only need to tap once. After that, install any of the formulae below
with a single `brew install` line.

## What's in here

| Formula | One line |
|---|---|
| [`trvl`](https://github.com/MikkoParkkola/trvl) | AI travel agent — Google Flights, Hotels, ground transport, MCP server, 33 CLI commands |
| [`axterminator`](https://github.com/MikkoParkkola/axterminator) | Background-first macOS GUI automation, MCP server, 30 tools, audio/camera capture |
| [`mcp-gateway`](https://github.com/MikkoParkkola/mcp-gateway) | Universal MCP gateway — single-port multiplexing, ~95% context-token savings |
| [`nab`](https://github.com/MikkoParkkola/nab) | Token-optimized HTTP client for LLMs — fetches any URL as clean markdown |
| [`nowifi`](https://github.com/MikkoParkkola/nowifi) | One-command captive-portal bypass, 27 techniques, restores everything on Ctrl+C |

## Install

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

Each install downloads a single pre-built binary for your architecture
(arm64 or x86_64, macOS or Linux) and finishes in 1–3 seconds. No build
toolchain required.

## Wire MCP servers into your AI client

`trvl` and `axterminator` ship as MCP servers. After installing them,
wire them into your AI client without editing any JSON:

```bash
trvl mcp install                         # Claude Desktop (default)
trvl mcp install --client cursor         # Cursor / Windsurf
trvl mcp install --client claude-code    # Claude Code
```

Then restart your client. Your assistant now has 33 travel tools.

## Update everything

```bash
brew update && brew upgrade
```

## Uninstall

```bash
brew uninstall trvl axterminator mcp-gateway nab nowifi
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
