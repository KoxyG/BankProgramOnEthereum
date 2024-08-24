const { ethers } = require("hardhat");

async function main() {
  const BankProgram = await ethers.getContractFactory("BankProgram");
  
  console.log("Deploying BankProgram...");
  const bankProgram = await BankProgram.deploy();  // Deploy the contract
  
  await bankProgram.deployed();  // Wait until the contract is deployed
  
  console.log("BankProgram deployed to:", bankProgram.address); 
  console.log("BankProgram deployed to:", bankProgram.address);
console.log("BankProgram contract details:", bankProgram);
 // Log the contract address
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("Error:", error);
    process.exit(1);
  });
