const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Check contract", function () {
  it("Challenge Solved", async function () {
    const [owner, solver] = await ethers.getSigners();
    const Check = await ethers.getContractFactory("contracts/check.sol:check");
    const Solve = await ethers.getContractFactory("Solve");

    const CheckContract = await Check.connect(owner).deploy();
    const SolveContract = await Solve.connect(solver).deploy(CheckContract.address);
    await SolveContract.connect(solver).solve();
    expect(await CheckContract.connect(solver).isSolved()).to.equal(true);


  });
});
