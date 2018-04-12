var Raffle = artifacts.require("./Raffle.sol");

const TICKETS = 10;
const PRICE = 1;

module.exports = function(deployer) {
  deployer.deploy(Raffle, TICKETS, PRICE, { value: 1*PRICE });
};