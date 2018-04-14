// contracts/Raffle.sol
pragma solidity ^0.4.17;


contract Raffle {
  
  uint public maxTickets;
  uint public price;
  address public creator;
  address[] public participants;
  address public winner;

  function Raffle(uint _maxTickets, uint _price) public payable {
    maxTickets = _maxTickets;
    price = _price;
    creator = msg.sender;
    joinraffle(1);
  }

  // purchase tickets
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

    if (participants.length == maxTickets) {
      return draw();
    }
    return true;
  }

  // award prize
  function draw() internal returns (bool) {

    uint seed = block.number;
    uint random = uint(keccak256(seed)) % participants.length;
    winner = participants[random];
    uint prize = maxTickets * price;
    winner.transfer(prize);
    return true;
  }
}