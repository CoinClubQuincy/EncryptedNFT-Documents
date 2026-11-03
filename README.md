<p align="center">
  <img src=".github/assets/banner.svg" alt="Encrypted NFT Documents: An NFT tied to an encrypted document kept off-chain" width="100%">
</p>

<p align="center">
  
<a href="https://github.com/CoinClubQuincy/EncryptedNFT-Documents/actions/workflows/build.yml"><img alt="build" src="https://github.com/CoinClubQuincy/EncryptedNFT-Documents/actions/workflows/build.yml/badge.svg"></a>  <img alt="network: any EVM" src="https://img.shields.io/badge/network-any%20EVM-2563eb">  <img alt="language: Solidity" src="https://img.shields.io/badge/language-Solidity-0e7490">  <img alt="status: proof of concept" src="https://img.shields.io/badge/status-proof%20of%20concept-b45309">  <img alt="license: MIT" src="https://img.shields.io/badge/license-MIT-475569">
</p>

<p align="center">
  <a href="#how-it-works">How it works</a> · <a href="#try-it">Try it</a> · <a href="#what-is-tested">What is tested</a> · <a href="#known-issues">Known issues</a>
</p>

This project ties an NFT to an encrypted document stored off-chain, such as on IPFS. The token's metadata points to the encrypted file. The contract stores only a hash of the decryption key, so someone who is given the key off-chain can confirm it is the right one.

> [!CAUTION]
> **Never put a decryption key in a contract, on any network that others can read.** Earlier versions stored it there, gated by a view function, and that did not hide it: anyone can read contract storage. Keys already stored in a deployed version are public and cannot be removed, so treat those documents as exposed. This contract has not been audited and has not run on a real network.

## How it works

```mermaid
sequenceDiagram
    participant O as Owner
    participant S as IPFS or other storage
    participant C as Documents contract
    participant H as Token holder
    O->>O: Encrypt the file with a random key
    O->>S: Store the encrypted file and metadata
    O->>C: Deploy with the key's hash and the metadata link
    O->>H: Transfer the NFT
    O->>H: Give the key privately, off-chain
    H->>S: Fetch the encrypted file
    H->>C: verifyKey(hash of the key)
    H->>H: Decrypt
```

| Function | What it does |
| --- | --- |
| `constructor(keyCommitment, uri)` | Stores the hash of the key and mints the NFT to the deployer |
| `viewKeyCommitment()` | Returns the stored hash |
| `verifyKey(keyHash)` | Tells you whether a hash matches |
| `uri(0)` | Returns the metadata link |

[`URI/metadata.json`](URI/metadata.json) is an example of the metadata.

**Choosing a key.** Use a long random key from a cryptographic generator. The earlier instructions built the key as the SHA-256 of the image's hash plus a fixed word. That is weak, because the metadata publishes the image's hash, so anyone could work out the key by guessing the word.

**Encrypting.** Use an established tool such as `age` or AES-GCM. The earlier instructions pointed to [safedun-server](https://github.com/adildsw/safedun-server), which describes itself as image scrambling. Scrambling is not the same as encryption, so don't rely on it to protect documents. This repo used to include it as a broken submodule link, which has been removed.

## Try it

```bash
git clone https://github.com/CoinClubQuincy/EncryptedNFT-Documents.git
cd EncryptedNFT-Documents
git clone --depth 1 -b v4.9.6 https://github.com/OpenZeppelin/openzeppelin-contracts lib/openzeppelin-contracts
git clone --depth 1 -b v1.9.7 https://github.com/foundry-rs/forge-std lib/forge-std
forge test
```

You need [Foundry](https://getfoundry.sh).

## What is tested

[`test/foundry/Documents.t.sol`](test/foundry/Documents.t.sol) has 6 tests, including one fuzz test, and runs in CI on every push. They cover the deployer holding the token, requiring a commitment, verifying only the right key, selling the token, and storage holding only the commitment. It has not been run on a real network or audited, and the encryption and key delivery are not part of this repo, so they are not tested.

## Changes from earlier versions

Contracts already deployed are unaffected, and **any key they store stays public**.

- The constructor takes a hash of the key instead of the key.
- `viewKey` was replaced by `viewKeyCommitment` and `verifyKey`.
- The broken `safedun-server` submodule link and the older Truffle test were removed.

## Known issues

| Issue | Effect |
| --- | --- |
| Delivering the key is up to you | The contract cannot give anyone the key. You need a private channel or a service that checks the token |
| Selling the token does not take back the key | A past holder who has the key can still decrypt. Encrypt again with a new key if that matters |
| A weak key can be guessed from its hash | The hash is public, so use a long random key |
| Metadata stored off-chain can disappear | If nobody keeps the IPFS file pinned, it can become unavailable |

## License

MIT, as declared in the SPDX headers of the source files. This repository has no separate license file.
