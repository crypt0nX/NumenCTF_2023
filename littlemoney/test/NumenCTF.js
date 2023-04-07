const { expect } = require("chai");
const { ethers } = require("hardhat");


describe("Numen contract", function () {
  it("Challenge Solved", async function () {
    hre.tracer.enabled = false;
    const [owner, solver] = await ethers.getSigners();
    const Numen = await ethers.getContractFactory("contracts/NumenCTF.sol:Numen");
    const NumenContract = await Numen.connect(owner).deploy();
    const Solve = await ethers.getContractFactory("contracts/solve.sol:Deployer");
    const SloveContract = await Solve.connect(solver).deploy();
    hre.tracer.enabled = true;
    await NumenContract.connect(solver).execute(SloveContract.address);
    hre.tracer.enabled = false;

  });
});
