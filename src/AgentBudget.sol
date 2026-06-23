// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title IERC20
/// @notice Core implementation of IERC20
/// @dev Built for Arc Network (Chain ID: 5042002)
interface IERC20 {
    /// @notice Execute transferFrom operation
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    /// @notice Execute transfer operation
    function transfer(address to, uint256 amount) external returns (bool);
}

/// @title AgentBudget
/// @notice Core implementation of AgentBudget
/// @dev Built for Arc Network (Chain ID: 5042002)
contract AgentBudget {
    IERC20 public immutable usdc;
    address public owner;
    uint256 public totalVolume;
    uint256 public paymentCount;
    mapping(address => uint256) public paidBy;
    mapping(address => uint256) public receivedBy;

    event Paid(uint256 indexed id, address indexed payer, address indexed recipient, uint256 amount, string memo);
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);
    event Swept(address indexed to, uint256 amount);

    constructor(address _usdc) {
        require(_usdc != address(0), "BAD_USDC");
        usdc = IERC20(_usdc);
        owner = msg.sender;
    }

    modifier onlyOwner() { require(msg.sender == owner, "NOT_OWNER"); _; }

    /// @notice Execute pay operation
    function pay(address recipient, uint256 amount, string calldata memo) external returns (uint256 id) {
        require(recipient != address(0), "BAD_RECIPIENT");
        require(amount > 0, "BAD_AMOUNT");
        require(usdc.transferFrom(msg.sender, recipient, amount), "TRANSFER_FROM_FAILED");
        id = ++paymentCount;
        paidBy[msg.sender] += amount;
        receivedBy[recipient] += amount;
        totalVolume += amount;
        emit Paid(id, msg.sender, recipient, amount, memo);
    }

    /// @notice Execute changeOwner operation
    function changeOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "BAD_OWNER");
        emit OwnerChanged(owner, newOwner);
        owner = newOwner;
    }

    /// @notice Execute sweep operation
    function sweep(address to, uint256 amount) external onlyOwner {
        require(usdc.transfer(to, amount), "TRANSFER_FAILED");
        emit Swept(to, amount);
    }
}
