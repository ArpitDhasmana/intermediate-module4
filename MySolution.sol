// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    event Redeem(address indexed from, uint256 itemId, uint256 quantity);

    // Constructor to initialize the token with the name "Degen Token" and symbol "DGNT"
    constructor() ERC20("Degen Token", "DGNT") Ownable(msg.sender) {}

    // Struct to represent an item in the in-game store
    struct Item {
        uint256 itemId;
        uint256 price;
        uint256 quantity;
    }

    // Struct to represent a player's inventory
    struct PlayerInventory {
        uint256 itemId;
        uint256 quantity;
    }

    mapping(uint256 => Item) public storeItems;
    mapping(address => PlayerInventory[]) public playerInventories;
    uint256 public itemCount;

    // Function to mint new tokens (only the owner can do this)
    function mint(address to, uint256 value) external onlyOwner {
        require(to != address(0), "Invalid address");
        require(value > 0, "Invalid value");

        _mint(to, value);
    }

    // Function to transfer and burn tokens (called during redemption)
    function transferAndBurn(address from, address to, uint256 amount) internal {
        require(from != address(0), "Invalid from address");
        require(to != address(0), "Invalid to address");
        require(amount > 0, "Amount must be greater than zero");

        _transfer(from, to, amount);
        _burn(to, amount);
    }

    // Function to redeem tokens for items in the in-game store
    function redeem(uint256 itemId, uint256 quantity) external {
        require(itemId > 0 && itemId <= itemCount, "Invalid item ID");
        require(quantity > 0, "Quantity must be greater than zero");
        require(storeItems[itemId].quantity >= quantity, "Item not available");

        // Calculate the total cost of the items
        uint256 totalCost = storeItems[itemId].price * quantity;
        // Check if the player has enough tokens to redeem the items
        require(balanceOf(msg.sender) >= totalCost, "Insufficient balance");

        // Transfer tokens from player to owner and then burn them
        transferAndBurn(msg.sender, owner(), totalCost);
        storeItems[itemId].quantity -= quantity;

        // Add the redeemed items to the player's inventory
        bool itemFound = false;
        for (uint256 i = 0; i < playerInventories[msg.sender].length; i++) {
            if (playerInventories[msg.sender][i].itemId == itemId) {
                playerInventories[msg.sender][i].quantity += quantity;
                itemFound = true;
                break;
            }
        }

        if (!itemFound) {
            playerInventories[msg.sender].push(PlayerInventory(itemId, quantity));
        }

        emit Redeem(msg.sender, itemId, quantity);
    }

    // Function to add items and their prices to the in-game store
    function addItem(uint256 itemId, uint256 price, uint256 initialQuantity) external onlyOwner {
        require(itemId > 0, "Invalid item ID");
        require(price > 0, "Invalid price");
        require(initialQuantity > 0, "Invalid quantity");
        require(storeItems[itemId].itemId == 0, "Item ID already exists");

        storeItems[itemId] = Item(itemId, price, initialQuantity);
        itemCount++;
    }

    // Function to burn tokens (anyone can do this)
    function burn(uint256 amount) external {
        require(amount > 0 && balanceOf(msg.sender) >= amount, "Insufficient balance");

        _burn(msg.sender, amount);
    }
}
