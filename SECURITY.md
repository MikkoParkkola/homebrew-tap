# Security Policy

## Reporting a Vulnerability

If you discover a security issue in this tap, please report it responsibly.

**Do NOT open a public GitHub issue for security vulnerabilities.**

Instead, email **mikko.parkkola@iki.fi** with:

1. The affected formula
2. The artifact URL, version, or checksum involved
3. Steps to reproduce
4. Impact assessment
5. Any suggested fix (optional)

You will receive an acknowledgment within 48 hours and an initial assessment within 7 days.

## Security Scope

This repository distributes Homebrew formula metadata, not the upstream tools themselves.

In scope:

- Incorrect or malicious download URLs
- Incorrect checksums or checksum validation gaps
- Unsafe formula install/test behavior
- Tap metadata changes that could redirect users to compromised release artifacts

Out of scope:

- Vulnerabilities in the upstream tools (`trvl`, `axterminator`, `mcp-gateway`, `nab`, `nowifi`) — report those in their canonical repos
- Local Homebrew configuration issues on an individual machine

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest `main` revision | :white_check_mark: |
| Older revisions | :x: |
