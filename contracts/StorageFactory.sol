// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;   // solidity versions 

// if you want to a contract smart contract, add it Directly under the pragma solidity above before the start of the second contract
// multiple contract are allowed in the same file

// contract SimpleStorage {
//     // favoriteNumber gets initialized to 0 if no value is given 
    
// uint256 myFavoriteNumber;  

// // uint256[] listOfFavoriteNumbers;
// struct Person {
//     uint256 favoriteNumber;
//     string name;
// }

// // dynamic array 
// Person[] public listOfPeople;  // []

// mapping(string => uint256) public nameToFavoriteNumber;     // we can use this instead of haivng to use the above line to search through the list, napping is set of keys returning information about a key

// function store(uint256 _favoriteNumber) public {
//     myFavoriteNumber = _favoriteNumber;
// }

// // view, pure 
// function retrieve() public view returns(uint256) {
//     return myFavoriteNumber;
//  }

// // calldata, memory, storage, calldata is temporary data that cannot be modified, memory is temporary data that can be modified, storage is permanent variable that can be modified
// function addPerson(string memory _name, uint256 _favoriteNumber) public {   // memory or calldata would mean that they would saved for short period of time because its in memory
//     Person memory newPerson = Person(_favoriteNumber, _name);  // this creates a new person
//     listOfPeople.push(newPerson); // this pushes the new person created to the list // list of people would be taken in form of index
//     nameToFavoriteNumber[_name] = _favoriteNumber; // add the name to the mapping above, _name is the maping ke, anytime you search a name you get the favorite number back
//     //  OR
//     // listOfPeople.push( Person(_favoriteNumber, _name) );
//     // six places to store data in solidity : stack, memory, storage, calldata, code, logs 
//   } 
// }           
// this above OR use the import below
import "./SimpleStorage.sol"; 

contract StorageFactory {
    // address[] public listOfSimpleStorageAddresses;   // an array of list of simplestorage of addresses
    
    // uint256 public favoriteNumber
    // type , visibility, name - type : SimpleStorage
    SimpleStorage[] public listOfSimpleStorageContracts;   // SimpleStorage: the first contract,  simpleStorage: as the variable in our contraact when the second contract StorageFactory

    function createSimpleStorageContract() public {
        SimpleStorage newSimpleStorageContract = new SimpleStorage();  // this means deploy the contract SimpleStorage again in this new contract and it should be represented in the new contract as simpleStorage
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }    
    
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {   // how to call the store function in simple storage
        // inorder to interact with a contract you need the address and abi, ABI tells a code how it can interact with another contract, remix looks at the ABI and creates the button for several 
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber);   // Simple storage interact with from our list, its like wrapping the addresses inside of simplestorage,  SimpleStorage(addresses)
    } 
    
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}    