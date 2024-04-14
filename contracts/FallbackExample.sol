// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract FallbackExample {
    uint256 public result;

    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}


// search for fallback in solidity website for more info check solidity doc for special functions., this one is for when a function that is not existing in your contract is called from a public contract to interact with your contract but the function called does not exist