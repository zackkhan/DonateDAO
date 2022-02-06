pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract YourContract {

  // event SetPurpose(address sender, string purpose);
  int public ethPrice;
  string public purpose = "Building Unstoppable Apps!!!!!!!";
  address public owner = 0xce5875ab4082f80c5C810f47FB81EDd9f5CE9e33;
  AggregatorV3Interface internal priceFeed;
  int public balance = 0;
  // balance = owner.balance;
  int public donation = 0;
  int public limit = 0;
  int public totalAmountDonated = 0;

  constructor() payable {
    priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
  }

  function setPurpose(string memory newPurpose) public payable {
      purpose = newPurpose;
      console.log(msg.sender,"set purpose to",purpose);
      ethPrice = getLatestPrice();
      // emit SetPurpose(msg.sender, purpose);
  }

  function withdraw() public payable {
      (bool sent,) = msg.sender.call{value: address(this).balance}("");
      require(sent, "failed to send eth");
  }

  function getLatestPrice() public view returns (int) {
    (
        uint80 roundID,
        int price,
        uint startedAt,
        uint timeStamp,
        uint80 answeredInRound
    ) = priceFeed.latestRoundData();
    return price / 1e8;
  }

  function getContractBalance() public view returns (uint) {
      console.log(msg.sender,"balance is", address(this).balance);
      return address(this).balance;
  }

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
