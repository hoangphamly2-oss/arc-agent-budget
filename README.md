# arc-agent-budget

AI agent budget guard on Arc testnet.

- Chain ID: `5042002`
- RPC: `https://rpc.testnet.arc.network`
- USDC: `0x3600000000000000000000000000000000000000`
- Explorer: https://testnet.arcscan.app

## Contract

`src/AgentBudget.sol` records USDC payments and emits accounting events.

## Build

```bash
forge build
```

## Deployment

- Contract: `0x13079b1ADF898eC3a0F742370DB04EEBE11447d0`
- Tx: `inferred-from-nonce`
- Explorer: https://testnet.arcscan.app/address/0x13079b1ADF898eC3a0F742370DB04EEBE11447d0
