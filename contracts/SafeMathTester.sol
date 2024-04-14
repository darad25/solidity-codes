// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SafeMathTester{
    uint8 public bigNumber = 255;  // checked, capprd uint8 to not be more than 255, it os unchecked if you make the version 0.6.0 or you see a cotract with it that is what it means

    function add() public  {
        bigNumber = bigNumber + 1;
        // unchecked {bigNumber = bigNumber + 1;} this would help save gas of transactions, so far your big number is capped
    }
}  