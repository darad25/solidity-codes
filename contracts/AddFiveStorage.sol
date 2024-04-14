// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {   // inheritance, ADDFIVESTORAGE CONTRACT FUNCTION THE SAME AS SIMPLE STORAGE  
     // +5, overrides, virtual override
     // USING OVERRIDE TO TELL SOLIDITY TO OVERWRITE STORE FUNCTION IN SimpleStorage, but you need to write virtual in base or parent class in the case that is simplestorage
     function store(uint256 _newNumber) public override {
       myFavoriteNumber = _newNumber + 5;
     }
}   