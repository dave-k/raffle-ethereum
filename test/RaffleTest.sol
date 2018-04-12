// test/RaffleTest.sol
pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "../contracts/Raffle.sol";


contract RaffleTest {
  uint public initialBalance = 10 ether;
  uint public maxTickets = 10;
  uint public price = 1;

  function testSetMaxTicketsAndTicketPrice() public {
    Raffle raffle = new Raffle(maxTickets, price);
    Assert.equal(raffle.maxTickets(), maxTickets, "Should set maximum tickets available");
  }
}
