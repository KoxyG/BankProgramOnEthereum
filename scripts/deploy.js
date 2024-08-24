const hre = require("hardhat");
async function main() {
    const BankProgram = await hre.ethers.getContractFactory("BankProgram");
    
    console.log("Deploying BankProgram...");
    const bankProgram = await BankProgram.deploy();
    
  
    await bankProgram.waitForDeployment();
  
    console.log("BankProgram deployed to:", await BankProgram.getAddress());
  }
  
  main()
    .then(() => process.exit(0))
    .catch((error) => {
      console.error(error);
      process.exit(1);
    });