// EVM is how to compile and deploy smart contracts / solidity to the blockchain

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;   // solidity versions 

contract SimpleStorage {
    // favoriteNumber gets initialized to 0 if no value is given 
    
uint256 myFavoriteNumber;  

// uint256[] listOfFavoriteNumbers;
struct Person {
    uint256 favoriteNumber;
    string name;
}

// dynamic array 
Person[] public listOfPeople;  // []

mapping(string => uint256) public nameToFavoriteNumber;     // we can use this instead of haivng to use the above line to search through the list, napping is set of keys returning information about a key

function store(uint256 _favoriteNumber) public virtual {
    myFavoriteNumber = _favoriteNumber;
}

// view, pure 
function retrieve() public view returns(uint256) {
    return myFavoriteNumber;
 }

// calldata, memory, storage, calldata is temporary data that cannot be modified, memory is temporary data that can be modified, storage is permanent variable that can be modified
function addPerson(string memory _name, uint256 _favoriteNumber) public {   // memory or calldata would mean that they would saved for short period of time because its in memory
    Person memory newPerson = Person(_favoriteNumber, _name);  // this creates a new person
    listOfPeople.push(newPerson); // this pushes the new person created to the list // list of people would be taken in form of index
    nameToFavoriteNumber[_name] = _favoriteNumber; // add the name to the mapping above, _name is the maping ke, anytime you search a name you get the favorite number back
    //  OR
    // listOfPeople.push( Person(_favoriteNumber, _name) );
    // six places to store data in solidity : stack, memory, storage, calldata, code, logs 
  } 
}             
// injected metamask in remix means we want remix to interact with our metamask, you can set metamask to sepolia for it to be as a form of testnet 