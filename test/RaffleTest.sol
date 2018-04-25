// test/RaffleTest.sol
pragma solidity ^0.4.22;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Raffle.sol";


contract RaffleTest {
  Raffle raffle;
  uint public initialBalance = 10 ether;
  uint public maxTickets = 10;
  uint public price = 1;

  // `fallback` function called when eth is sent to Payable contract
  function () public payable { }

  function beforeEach() public {
    uint qty = 1;
    raffle = (new Raffle).value(price * qty)(maxTickets, price);
  }

  function testSetMaxTickets() public {
    Assert.equal(raffle.maxTickets(), maxTickets, "Should set maximum tickets available");
  }

  function testSetTicketPrice() public {
    Assert.equal(raffle.price(), price, "Should set ticket price");
  }

  function testSettingAnOwnerDuringCreation() public {
    Assert.equal(raffle.creator(), this, "An owner is different than a deployer");
  }

  function testFirstTicketSoldToCreator() public {
    Assert.equal(raffle.participants(0), this, "Should sell first ticket to creator");
  }

  function testSettingAnOwnerOfDeployedContract() public {
    raffle = Raffle(DeployedAddresses.Raffle());
    Assert.equal(raffle.creator(), msg.sender, "An owner is different than a deployer");
  }

  function testTicketPurchase() public {
    uint qty = 2;
    raffle.joinraffle.value(price * qty)(qty);
    Assert.equal(raffle.participants(qty), this, "Should sell tickets");
  }

  function testUnderPayment() public {
    uint qty = 2;
    Assert.isFalse(raffle.joinraffle.value(0)(qty), "Should fail for under payment");
  }

  function testOverSubscription() public {
    uint qty = maxTickets + 1;
    Assert.isFalse(raffle.joinraffle.value(price * qty)(qty), "Should fail for over subscription");
  }

  function testPrizeAwarded() public {
    uint qty = maxTickets - 1;
    Assert.equal(raffle.winner(), 0, "winner should be zero before prize is awarded");

    Assert.isTrue(raffle.joinraffle.value(price * qty)(qty), "Should award prize equal to the sum of all the tickets");
    Assert.notEqual(raffle.winner(), 0, "winner should be zero before prize is awarded");
  }
}
