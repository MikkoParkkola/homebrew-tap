# Contributing

Thanks for helping improve the tap.

## Scope

This repository contains Homebrew formula metadata only.

- **Formula bugs belong here**: broken download URLs, checksum mismatches, install/test failures, or tap metadata problems
- **Upstream tool bugs do not**: feature requests and runtime bugs for `trvl`, `axterminator`, `mcp-gateway`, `nab`, and `nowifi` should go to their canonical repos

## Development Workflow

1. Fork the repository
2. Create a feature branch
3. Make a focused formula or metadata change
4. Validate locally before opening a pull request

## Local Validation

If you want Homebrew to evaluate this local checkout as a tap:

```bash
brew tap MikkoParkkola/tap "$PWD"
brew style MikkoParkkola/tap
brew audit --strict --online --tap MikkoParkkola/tap
```

When you are done, you can remove the local tap with:

```bash
brew untap MikkoParkkola/tap
```

## Pull Requests

- Keep changes limited to the relevant formulae or tap metadata
- Update checksums together with URL or version changes
- Include enough context to show which upstream release or packaging issue the change addresses
