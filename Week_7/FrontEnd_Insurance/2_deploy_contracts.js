const ConvertLib = artifacts.require("ConvertLib");
const TechInsurance = artifacts.require("TechInsurance");

module.exports = function(deployer) {
  deployer.deploy(TechInsurance);
};
