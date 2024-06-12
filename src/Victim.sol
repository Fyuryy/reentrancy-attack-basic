// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

// THIS CONTRACT CONTAINS A BUG - DO NOT USE

import "forge-std/Test.sol";

contract Victim is Test {
    /// @dev Mapping of ether shares of the contract.    
    mapping(address => uint256) shares;
    bool reentrancy = false;

    modifier nonReentrant() {
        if (reentrancy == true) {
            revert("Reverted");
        } else {
            reentrancy = true;
            _;
        }
    }

    /// Withdraw your share.
    function withdraw() public nonReentrant {
        uint256 amount = shares[msg.sender];
        shares[msg.sender] = 0;
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed");
    }

    function deposit() external payable {
        shares[msg.sender] += msg.value;
    }
}
