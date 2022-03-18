const { expect } = require("chai");
const { ethers } = require("hardhat");

// describe("MyContract", function () {
//   it("Should return the new greeting once it's changed", async function () {
//     const MyContract = await ethers.getContractFactory("MyContract");
//     const greeter = await MyContract.deploy("Hello, world!");
//     await myContract.deployed();

//     expect(await myContract.greet()).to.equal("Hello, world!");

//     const setGreetingTx = await myContract.setGreeting("Hola, mundo!");

//     // wait until the transaction is mined
//     await setGreetingTx.wait();

//     expect(await myContract.greet()).to.equal("Hola, mundo!");
//   });
// });
