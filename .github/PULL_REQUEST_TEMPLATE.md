## What does this PR do?

## How to test

```bash
brew tap MikkoParkkola/tap "$PWD"
brew style MikkoParkkola/tap
brew audit --strict --online --tap MikkoParkkola/tap
```

## Checklist

- [ ] Formula URLs, versions, and checksums are in sync
- [ ] `brew style MikkoParkkola/tap` passes
- [ ] `brew audit --strict --online --tap MikkoParkkola/tap` passes
- [ ] README/docs updated if needed
