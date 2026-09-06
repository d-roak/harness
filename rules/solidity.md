# Solidity

- Foundry. `forge fmt`, `forge build`, `forge test -vvv`, `forge coverage` as the gate.
- Pin `pragma solidity` to one version. OpenZeppelin for anything standard (ERC20, access, upgradeable proxies).
- Checks-effects-interactions. Reentrancy guard on every external call that moves value.
- Custom errors over `require` strings. Events for every state change a frontend or indexer cares about.
- No unbounded loops over user-controlled arrays. No `tx.origin`. No floating point tricks: fixed-point libraries or basis points.
- Access control explicit and tested: who can call what, and a test proving the wrong caller reverts.
- Fuzz tests (`testFuzz_`) and invariant tests for any accounting. Fork tests against mainnet state when integrating.
- Deploy scripts in `script/`, broadcast only with an explicit flag. Verify on the explorer after deploy.
- Every contract that holds funds goes through the `audit` skill before deploy. Slither run clean or every finding explained.
