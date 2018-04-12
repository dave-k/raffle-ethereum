// contracts/Raffle.sol
pragma solidity ^0.4.17;


contract Raffle {
  
  uint public maxTickets;
  uint public price;
  address public creator;
  address[] public participants;

  function Raffle(uint _maxTickets, uint _price) public payable {
    maxTickets = _maxTickets;
    price = _price;
    creator = msg.sender;
    joinraffle(msg.value);
  }

  // purchase ticket
  function joinraffle(uint _qty) public payable returns(bool) {

    if (msg.value < price * _qty) {
      return false;
    }

    if (int(participants.length) > int(maxTickets - _qty)) {
      return false;
    }

    for (uint i = 0; i < _qty; i++) {
      participants.push(msg.sender);
    }
  }
}