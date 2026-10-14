# Release

```
verify → audit? → ship (pr) → CI/review green → ship (merge) → ship (deploy) → smoke
```

1. `verify` on the release branch from a clean checkout.
2. `audit` if anything since the last release touched money, auth, data, or infra. Contracts: always.
3. `ship` PR to `main` with release notes grouped by feat / fix / chore.
4. Wait for CI and review. Red CI is a `debug`, never a retry.
5. `ship` merge the PR only on instruction.
6. `ship` deploy to the named target (Dokploy, Vercel, GitHub Pages, contract broadcast).
7. Smoke: hit the health endpoint, load the page, call the contract read. Paste the result.
8. Watch logs for ten minutes. Rollback is the previous image or the previous commit, and it is a `ship` action with its own instruction.
