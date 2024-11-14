// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TokenBank.sol";

contract TankBankTest is Test {
    TokenBankChallenge public tokenBankChallenge;
    TokenBankAttacker public tokenBankAttacker;

    function setUp() public {}

    function testExploit() public {
        tokenBankAttacker = new TokenBankAttacker();
        tokenBankChallenge = new TokenBankChallenge(address(tokenBankAttacker));
        tokenBankAttacker.initialize(address(tokenBankChallenge));

        // Put your solution here
        tokenBankAttacker.exploit();
        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(tokenBankChallenge.isComplete(), "Challenge Incomplete");
    }
}
