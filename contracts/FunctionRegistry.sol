// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

contract FunctionRegistry {
    // Mapping to store implementation addresses for different function IDs
    mapping(bytes4 => address) private implementations;

    // Event emitted when an implementation address is updated
    event ImplementationUpdated(bytes4 indexed functionId, address indexed implementation);

    // Modifier to restrict access to the contract owner only
    modifier onlyOwner() {
        require(msg.sender == owner, "FunctionRegistry: unauthorized");
        _;
    }

    // Owner address
    address public owner;

    // Constructor to set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to update the implementation address for a specific function ID
    function updateImplementation(bytes4 _functionId, address _implementation) external onlyOwner {
        // Update the implementation address
        implementations[_functionId] = _implementation;

        // Emit an event to signal the update
        emit ImplementationUpdated(_functionId, _implementation);
    }

    // Function to remove an implementation address for a specific function ID
    function removeImplementation(bytes4 _functionId) external onlyOwner {
        delete implementations[_functionId];
        emit ImplementationUpdated(_functionId, address(0));
    }

    // Function to get the implementation address for a specific function ID
    function getImplementation(bytes4 _functionId) external view returns (address) {
        return implementations[_functionId];
    }

    // Function to transfer ownership of the contract
    function transferOwnership(address _newOwner) external onlyOwner {
        require(_newOwner != address(0), "FunctionRegistry: invalid owner address");
        owner = _newOwner;
    }
}