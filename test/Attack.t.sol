// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.6.0 <0.9.0;

import "forge-std/Test.sol";
import "src/Victim.sol";
import "src/Attacker.sol";

contract Attack is Test {
    Victim victim;
    Attacker attacker;

    function setUp() public {
        address alice = makeAddr("Alice");
        vm.deal(alice, 50e18);
        victim = new Victim();
        vm.prank(alice);
        victim.deposit{value: 10e18}();
        attacker = new Attacker(address(victim));
    }

    function testReentrancy() public {
        console.log("Attacker balance:", address(attacker).balance);
        attacker.attack{value: 2e18}();
        console.log("Attacker balance:", address(attacker).balance);
    }
}
