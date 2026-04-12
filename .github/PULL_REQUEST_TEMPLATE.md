## What does this PR do?

## How to test

```bash
brew tap local/homebrew-quality "$PWD"
brew style local/homebrew-quality
brew audit --strict --online --tap local/homebrew-quality
```

## Checklist

- [ ] Formula URLs, versions, and checksums are in sync
- [ ] `brew style local/homebrew-quality` passes
- [ ] `brew audit --strict --online --tap local/homebrew-quality` passes
- [ ] README/docs updated if needed
