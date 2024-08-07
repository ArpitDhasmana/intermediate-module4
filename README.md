# Degen Token

Simple overview of use/purpose.

## Description

Degen Token (DGNT) is an ERC20 token designed to serve both as a cryptocurrency and an in-game currency for decentralized applications. It includes features for minting new tokens, redeeming tokens for items in an in-game store, and burning tokens. The contract owner can add new items to the store, which players can then purchase using their DGNT tokens. The smart contract is built using Solidity and leverages the OpenZeppelin library for secure and efficient implementation.

## Getting Started

### Installing

* Ensure you have the following:
  - MetaMask wallet
  - Avalanche test network setup in MetaMask
  - Faucet AVAX from Chainlink to execute the transactions

* How/where to download your program:
  1. **Open Remix IDE:**
     Navigate to [Remix IDE](https://remix.ethereum.org/).

  2. **Import the contract:**
     Create a new file in Remix and paste the Degen Token smart contract code.

  3. **Compile the smart contract:**
     Select the appropriate Solidity compiler version (0.8.x) and compile the contract.

  4. **Deploy the contract:**
     - Connect MetaMask to Remix IDE.
     - Ensure MetaMask is connected to the Avalanche test network.
     - Deploy the contract using the MetaMask wallet.

### Executing program

* How to run the program:
  1. **Minting tokens:**
     The contract owner can mint new tokens to a specific address.
     ```
     DegenTokenInstance.mint('0xYourAddress', 1000);
     ```

  2. **Adding items to the store:**
     The contract owner can add new items to the in-game store.
     ```
     DegenTokenInstance.addItem(1, 50, 10); // itemId, price, initialQuantity
     ```

  3. **Redeeming items:**
     Players can redeem their tokens for items in the store.
     ```
     DegenTokenInstance.redeem(1, 2); // itemId, quantity
     ```

  4. **Burning tokens:**
     Any token holder can burn their tokens.
     ```
     DegenTokenInstance.burn(100);
     ```

## Help

Any advice for common problems or issues:
* Ensure you have sufficient balance for the operations you're trying to perform.
* Verify the item ID exists and has enough quantity for redemption.
* Confirm the contract is deployed correctly and you're interacting with the correct address.

For more assistance, you can use the Remix IDE console to interact directly with your deployed contracts.

## Authors

Arpit Dhasmana  
[@TwitterHandle](https://twitter.com/TwitterHandle)

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
