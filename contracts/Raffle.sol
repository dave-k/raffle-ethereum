// contracts/Raffle.sol
pragma solidity ^0.4.22;

/*
  Requirements:
    The creator sets the number of tickets and ticket price
    The creator must purchase the first ticket on creation
    Participants can buy as many tickets as are available
    The prize is awarded to a random participant once all tickets are sold
*/

contract Raffle {
  
  uint public maxTickets;
  uint public price;
  address public creator;
  address[] public participants;
  address public winner;

  event JoinEvent(uint _length);
  event DrawEvent(address _winner, uint _prize);

  function Raffle(uint _maxTickets, uint _price) public payable {
    maxTickets = _maxTickets;
    price = _price;
    creator = msg.sender;
    uint qty = 1;
    joinraffle(qty);
  }

  // `fallback` function called when eth is sent to Payable contract
  function () public payable {
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

    emit JoinEvent (participants.length);
    
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
    uint prize = address(this).balance; // maxTickets * price;
    emit DrawEvent (address(winner), prize);
    address(winner).transfer(prize);
    return true;
  }
}