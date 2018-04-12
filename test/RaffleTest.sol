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

  function testTicketPurchase() public {
    uint qty = 2;
    raffle.joinraffle.value(price*qty)(qty);
    Assert.equal(raffle.participants(qty), this, "Should sell tickets");

    Assert.isFalse(raffle.joinraffle.value(1)(qty), "Should fail for under payment");
  }

  function testCanSellMoreThanMaxTickets() public {
    uint qty = maxTickets + 1;
    Assert.isFalse(raffle.joinraffle.value(price*qty)(qty), "Should fail for over ticket limit");
  }

  function testIsPrizeAwarded() public {
    uint qty = maxTickets - 1;
    raffle.joinraffle.value(price * qty)(qty);
    uint prize = maxTickets * price;
    Assert.equal(raffle.winner().balance, prize, "Should award prize equal to the sum of all the tickets");
  }
}
