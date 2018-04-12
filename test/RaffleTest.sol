// test/RaffleTest.sol
pragma solidity ^0.4.17;

import "truffle/Assert.sol";
import "../contracts/Raffle.sol";


contract RaffleTest {
  Raffle raffle;
  uint public initialBalance = 10 ether;
  uint public maxTickets = 10;
  uint public price = 1;

  function beforeEach() public {
    raffle = (new Raffle).value(1*price)(maxTickets, price);
  }

  function testSetMaxTicketsAndTicketPrice() public {
    Assert.equal(raffle.maxTickets(), maxTickets, "Should set maximum tickets available");
  }

  function testSetCreatorDuringContractCreation() public {
    Assert.equal(raffle.creator(), this, "Should set creator during contract creation");
  }

  function testFirstTicketSoldToCreator() public {
    Assert.equal(raffle.participants(0), this, "Should sell first ticket to creator");
  }
}
