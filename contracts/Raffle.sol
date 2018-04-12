// contracts/Raffle.sol
pragma solidity ^0.4.17;


contract Raffle {
  
  uint public maxTickets;
  uint public price;
  address public creator;

  function Raffle(uint _maxTickets, uint _price) public {
    maxTickets = _maxTickets;
    price = _price;
    creator = msg.sender;
  }
}