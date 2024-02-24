// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

  async function main() {

      const functionRegistry = await hre.ethers.deployContract("FunctionRegistry");
  
    await functionRegistry.waitForDeployment();
  
    console.log("functionREgistry deployed to:", functionRegistry.target
    );
   
    const proxyContract = await hre.ethers.deployContract("ProxyContract", [functionRegistry.target]);
  
    await proxyContract.waitForDeployment();
  
    console.log("proxyContract deployed to:",  proxyContract.target
    );

  

 
    

    // const stakingToken = await hre.ethers.deployContract("StakingToken");
  
    // await stakingToken.waitForDeployment();
  
    // console.log("stakingToken deployed to:",  stakingToken.target()
    // );

  
  
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
