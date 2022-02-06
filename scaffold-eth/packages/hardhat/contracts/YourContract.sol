pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

AggregatorV3Interface internal priceFeed;
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

  // event SetPurpose(address sender, string purpose);

  string public purpose = "Building Unstoppable Apps!!!";

  address public owner = 0xb68F761056eF1044eDf8E15646c8412FB86Cf6F2;

  constructor() payable {
    // what should we do on deploy?
  }

// payable allows us to send eth to a function
  function setPurpose(string memory newPurpose) public payable {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      console.log(owner.balance);
      // emit SetPurpose(msg.sender, purpose);
  }

  function withdraw() public payable   {
    // abi.encode(address(this))
    // this is saying that msg.sender wants money from the contract
      (bool sent, ) = msg.sender.call{value: address(this).balance}("");
      require(sent, "Failed to send Ether");
  }

  // to support receiving ETH by default
  receive() external payable {
  }
  fallback() external payable {}
}
