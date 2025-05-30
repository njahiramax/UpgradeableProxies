
# 🔄 Upgradeable Smart Contracts with Foundry and OpenZeppelin

This project demonstrates how to build, test, and upgrade Ethereum smart contracts using the **UUPS proxy pattern** provided by OpenZeppelin. It uses the **Foundry** framework for testing and scripting.

The contracts include:
- `BoxV1`: A simple contract with a `uint256` value and version reporting.
- `BoxV2`: An upgrade of `BoxV1` that adds new functionality.
- `ERC1967Proxy`: A transparent upgradeable proxy pointing to the implementation contract.
- Scripts to deploy and upgrade the contracts using Foundry's `broadcast`.

---

## 📂 Project Structure

```

upgradeables\_and\_proxies/
├── src/
│   ├── BoxV1.sol             # Initial contract logic
│   ├── BoxV2.sol             # Upgraded contract logic
│   ├── DeployBox.sol         # Deployment script for BoxV1
│   ├── UpgradeBox.sol        # Upgrade script to BoxV2
│
├── test/
│   └── DeployAndUpgradeTest.t.sol  # End-to-end upgrade test
│
├── foundry.toml              # Foundry config
├── README.md                 

````

---

## 🚀 Goal

To show how to:
1. Deploy a UUPS upgradeable contract.
2. Write and run a test that upgrades the contract from V1 to V2.
3. Understand the storage layout and upgrade flow.
4. Use OpenZeppelin upgradeable base contracts properly.

---

## 🧱 Contracts

### `BoxV1.sol`

This contract:
- Inherits from `OwnableUpgradeable` and `UUPSUpgradeable`.
- Stores a `uint256` called `number`.
- Has a `version()` function that returns `1`.
- Implements `_authorizeUpgrade()` using `onlyOwner`.

**Key Functions:**
```solidity
function initialize() public initializer;
function getNumber() external view returns (uint256);
function version() external pure returns (uint256);
````

### `BoxV2.sol`

Adds:

* A `setNumber(uint256)` function to mutate the state.
* Overrides `version()` to return `2`.

---

## 🛠 Scripts

### `DeployBox.sol`

* Deploys `BoxV1`.
* Creates a `ERC1967Proxy` using the `BoxV1` logic contract and initializes it via `initialize()`.

### `UpgradeBox.sol`

* Deploys `BoxV2`.
* Calls `upgradeTo()` via the proxy to point to `BoxV2`.

---

## 🧪 Tests

### `DeployAndUpgradeTest.t.sol`

This test:

1. Calls `DeployBox.run()` to deploy BoxV1 via proxy.
2. Calls `UpgradeBox.upgradeBox()` to upgrade the proxy to BoxV2.
3. Interacts with the proxy as BoxV2 to confirm state was preserved and functions are working.

---

## ✅ Requirements

* [Foundry](https://book.getfoundry.sh/getting-started/installation)
* OpenZeppelin upgradeable contracts: `forge install OpenZeppelin/openzeppelin-contracts-upgradeable`

---

## 📦 Installation

```bash
git clone https://github.com/njahiramax/UpgradeableProxies.git
cd upgradeables_and_proxies
forge install
```

---

## 🧪 Running Tests

```bash
forge test -vvv
```

You should see output that shows:

* Contract deployment and upgrade working as expected.
* Events for `Upgraded`, `Initialized`, and `OwnershipTransferred`.

---

## ⚠️ Notes on Upgradeability

* Only use `initializer` functions. Never use constructors in logic contracts.
* Always preserve storage layout when upgrading.
* `onlyOwner` is required in `_authorizeUpgrade()` to prevent unauthorized upgrades.

---

## 🔐 Security Practices

* Upgrade is protected by OpenZeppelin’s `onlyOwner`.
* Initializers prevent re-initialization.
* Contracts are fully compatible with OpenZeppelin’s storage layout and tools.

---

## 🧠 Why UUPS?

UUPS proxies:

* Are cheaper to deploy than transparent proxies.
* Give you direct control over upgrade logic inside the implementation.
* Still maintain upgrade security via `_authorizeUpgrade`.

---

## 📌 Future Ideas

* Add version history tracking.
* Extend tests to include fuzzing and edge cases.
* Deploy on testnet and verify upgrade process on-chain.
* Integrate Hardhat plugin for upgrades for hybrid workflows.

---

## 📄 License

MIT

---



## 📸 Demo

You can include a screenshot or terminal log of a successful deployment and upgrade.

```
✅ BoxV1 deployed at: 0x...
✅ Proxy deployed at: 0x...
✅ Upgrade to BoxV2 successful
```

---

## ✍️ Example Usage

```solidity
BoxV2(proxy).setNumber(42);
assert(BoxV2(proxy).getNumber() == 42);
```

---

## 💬 Feedback

Open an issue or reach out if you spot a bug or want to suggest improvements.

```

---

Let me know if you want a version that includes Markdown screenshots, diagrams, or links to on-chain deployments.
```
