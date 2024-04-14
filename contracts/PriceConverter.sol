// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.9; 

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
     function getPrice() internal view returns(uint256){  // using internal beacause it is used for a library
      // you need the address and abi
      AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
      (,int256 price,,,) = priceFeed.latestRoundData();
   
      return uint256(price * 1e10);

     } 
     
     function getConversionRate(uint256 ethAmount) internal view returns (uint256){
         uint256 ethPrice = getPrice();
         uint256 ethAmountInUsd = (ethPrice + ethAmount) / 1e18;
         return ethAmountInUsd;
     }

     function getVersionRate() public view returns (uint256){
       return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();    // address represents the address that has that contract interface, you compile to get the abi/interface of that contract
     }


}