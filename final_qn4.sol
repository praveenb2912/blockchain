// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {

  // Mapping to store user data with address as key
  mapping(address => person) public users;

  // Struct to define user information
  struct person {
    address x;
    uint balance;
    uint loan_req;
    uint loan_pending;

  }

  // Address of the contract owner
  address payable public owner;

  // Modifier to restrict functions to the owner
  modifier admin() {
    require(msg.sender == owner, "Only owner can call this function");
    _;
  }

  // Constructor to set the owner during deployment
  constructor() {
    owner = payable(msg.sender);
  }

  // Function to set a new user address (if not already present)
  function setUserAddress(address _userAddress) public {
    if (users[_userAddress].x == address(0)) {
      users[_userAddress] = person(_userAddress, 0, 0,0); // Initialize new user
    }
  }

  // Function to get the bank balance of a user
  function getBankBalance(address _userAddress) public view returns (uint) {
    return users[_userAddress].balance;
  }

  // Function to deposit funds into a user's account
  function deposit() public payable {
    require(msg.value > 0, "Deposit amount must be positive");
    users[msg.sender].balance += msg.value;
    owner.transfer(msg.value);
  }
  function loan__req(uint amount) private pure returns(uint) {
    return amount;
  }
  // Function for the owner to provide a loan to a user
  function loan(address _userAddress, uint _amount) public {
    require(_amount > 0, "Loan amount must be positive");
    users[_userAddress].loan_req+= loan__req(_amount);
    users[_userAddress].loan_pending+= loan__req(_amount);

  }

  function sendLoan(address _address) public payable admin {
    require(msg.value > 0, "Loan amount must be positive");
    users[_address].loan_req -= uint(msg.value);
    users[_address].balance += uint(msg.value);
    payable(_address).transfer(msg.value);
    
  }
  function contract1_eth() public payable{
    payable(address(this)).transfer(msg.value);
  }

  function repayLoan() public payable {
    users[msg.sender].loan_pending -= msg.value;
    owner.transfer(msg.value);
  }
}
