async function main() {
  const [owner, solver] = await ethers.getSigners();
  const Numen = await ethers.getContractFactory("contracts/NumenCTF.sol:Numen");
  const NumenContract = await Numen.connect(owner).deploy();
  const Solve = await ethers.getContractFactory("contracts/solve.sol:Deployer");
  const SloveContract = await Solve.connect(solver).deploy();
  await NumenContract.connect(solver).execute(SloveContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });