// Get funds from users 
// Withdraw funds
// Set a minimum funding value in USD, for people donating
// what is left for you is to write the function to send created token to this addresses that sent funds in
// i_owner - such an immutable variable cannot be changed when after deploying the contract
// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.9; 
   // calling an abi of a different contract manually to interact with that contract in this contract, ( abi can only be gotten after compiling the interface of the contract)
   // https://github.com/Cyfrin/remix-fund-me-f23/blob/main/PriceConverter.sol

// pragma solidity ^0.7.0;

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   // getRoundData and latestRoundData should both raise "No data present"
//   // if they do not have data to report, instead of returning unset values
//   // which could be misinterpreted as actual reported values.
//   function getRoundData(uint80 _roundId)
//     external
//     view
//     returns (
//       uint80 roundId,
//       int256 answer,
//       uint256 startedAt,
//       uint256 updatedAt,
//       uint80 answeredInRound
//     );

//   function latestRoundData()
//     external
//     view
//     returns (
//       uint80 roundId,
//       int256 answer,
//       uint256 startedAt,
//       uint256 updatedAt,
//       uint80 answeredInRound
//     );
// }

// OR THE OTHER FIRST IMPORT STYLE I LEARNT BELOW - import {AggregatorV3Interface} from "./AggregatorV3interface.sol";
// OR

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
     using PriceConverter for uint256;

     uint256 public minimumUsd = 5e18;    // uint256 public constant minimumUsd = 5e18;  also constant to reduce gas prices, also immutable if you are setting the variable once

     address[] public funders; // SAVING FUNDERS ADDRESSES 
     mapping(address funder => uint256 amountFunded) public addressToAmountFunded;   // FUNDERS

     // to help stop withdraw function been called by hackers or public
     address public owner;

     constructor()  {
        owner = msg.sender;
     }

     function fund() public payable {
        // msg.value.getConversionRate(); 
        // the reason why it sends is that, there is value input which represents amount in contract 
        // Allow users to send payable
        // Have a minimum $ sent , eth-comverter.com to get 1e18 (10000 up to 18 zeros) conversion to ether worth
        // 1. How do we send ETH to this  contract ?
        require(msg.value.getConversionRate() >= minimumUsd, "didnt send enough ETH");  // Funders
        funders.push(msg.sender);   // MEANS THE SENDER OF MONEY TO THE CONTRACT, funders that sent in money , 
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;  //  Funders,   addressToAmountFunded[msg.sender] += msg.value;
        // addressToAmountFunded[msg.sender] += msg.value;  //  how to write the above line in a shorter form
        // msg.value reads in eth , so you have to use chainlink oracle to convert the usd amount to eth worth
        // REVERT UNDO ANY ACTIONS THAT HAVE BEEN DONE, AND SEND THE REMAINING GAS BACK FOR THE INCOMPLETED TEANSACTIONS AFTER THE REVERT STATEMENT 
        // chain oracle nodes takes life data from exchanges sends them into a sub contract, https://data.chain.link/feeds?categories=Crypto that is the website
        //  at the bottom there users and sponsors that keep the chainlink node running, whenever node operator delivers data to smart contract, chanlink operators are paid a bit of oracle gas, the users of the protocol ( oracle ) are sponsoring keeping the price feeds up and are paying the oracle gas associated with delivering the data on chain
     }

     function withdraw() public onlyOwner {
      // for loop 
      // [1, 2, 3, 4] elements
      // 0, 1, 2, 3  indexes
      //  for(/* starting index, ending index, step amount*/) 
      // 0, 10, 1
      // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
      require(msg.sender == owner, "Must be owner!");   // owner to be the only one that can call this function, you can put this line in other functions that you want to be owner restricted or use modify to avoid using the line repeatedly
      for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
         address funder = funders[funderIndex]; // to access the 0th element of our funders array
         addressToAmountFunded[funder] = 0;
      } // when the funders index is greater funders length that is the lemgth of a funders array [array containing all the funders ] the tracsaction should end, "funderIndex = funderIndex + 1" for everytime we loop , you can use "fundersIndex++" as shorter line for it
      // 2, 12, 2
      // 2, 4, 6, 8, 10, 12

      funders = new address[](0);  // to reset the funders array to brand new ideas
      // to withdraw funds you can use transfer, send, call. https://solidity-by-example.org/sending-ether/
      // msg.sender = address
      // payable(msg.sender) = payable address
      payable(msg.sender).transfer(address(this).balance);   // transfer method, 'this' means this contract 
      // send
      bool sendSuccess = payable(msg.sender).send(address(this).balance);
      require(sendSuccess, "Send failed");
      // call and reset arra
      (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
      require(callSuccess, "Call failed");
      revert();
   }

   modifier onlyOwner() {
      // require(msg.sender == owner, "Sender is not owner!");
     if(msg.sender != owner) { revert NotOwner(); }
      _;  // this sognifies the point then other stuffs in code will run after the above require
   }
   
   receive() external payable {
      fund();
   }

   fallback() external payable {
      fund();
   }
} 

// solidity by example library , in a case you want create a library in a contract , a library is embedded into the contract if all library functions are inteernal
// to signal input of a number it is int256 to call it use uint256 