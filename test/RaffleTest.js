// test/RaffleTest.js
const Raffle = artifacts.require("Raffle");

const TICKETS = 10;
const PRICE = 1;

contract("Raffle", accounts => {
  const [firstAccount, secondAccount, thirdAccount] = accounts;
  let raffle;

  beforeEach(async () => {
    let qty = 1;
    raffle = await Raffle.new(TICKETS, PRICE, { value: qty*PRICE });
  });
  
  it("sets the creator", async () => {
    assert.equal(await raffle.creator.call(), firstAccount);
  });

  it("sets maximum tickets available", async () => {
    assert.equal(await raffle.maxTickets.call(), TICKETS);
  });

  it("sets the ticket price", async () => {
    assert.equal(await raffle.price.call(), PRICE);
  });

  it("sells first ticket to the creator", async () => {
    assert.equal(await raffle.participants(0), firstAccount);
  });

  it("sells a ticket", function() {
    return Raffle.deployed().then(function(instance) {
      let qty = 1;
      return instance.joinraffle.call(qty,{value:qty*PRICE, from: secondAccount});
    }).then(function(result) {
      assert.equal(result, true, "should sell a ticket");
    });
  });

  it("checks for insufficent payment", function() {
    return Raffle.deployed().then(function(instance) {
      let qty = 2;
      return instance.joinraffle.call(qty,{value:0});
    }).then(function(result) {
      assert.equal(result, false, "should check for insufficent payment");
    });
  });

  it("checks for request for too many tickets", function() {
    return Raffle.deployed().then(function(instance) {
      let qty = TICKETS + 1;
      return instance.joinraffle.call(qty,{value:qty*PRICE});
    }).then(function(result) {
      assert.equal(result, false, "should check for over selling");
    });
  });

  it("awards the prize", async () => {
    let qty = TICKETS-1;
    assert.equal(await raffle.joinraffle.call(qty,{value:qty*PRICE, from: secondAccount}), true);
  });
});