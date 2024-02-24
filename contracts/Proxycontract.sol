// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;

import "./FunctionRegistry.sol";

contract ProxyContract {
    // Address of the registry contract
    address private registry;

    constructor(address _registry) {
        registry = _registry;
    }

    fallback() external payable {
        bytes4 functionId;
        assembly {
            // Retrieve the function selector from the first 4 bytes of the calldata
            functionId := calldataload(0)
        }

        // Retrieve the corresponding contract address from the registry
        address contractLogic = FunctionRegistry(registry).getImplementation(functionId);
        require(contractLogic != address(0), "Function not implemented");

        assembly {
            // Delegate the call to the contractLogic address
            let success := delegatecall(gas(), contractLogic, 0, calldatasize(), 0, 0)

            // Retrieve the return data
            let retSz := returndatasize()
            returndatacopy(0, 0, retSz)

            // Forward the return data or revert if the delegate call failed
            switch success
            case 0 {
                revert(0, retSz)
            }
            default {
                return(0, retSz)
            }
        }
    }
}
