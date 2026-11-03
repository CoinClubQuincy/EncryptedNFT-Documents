const Documents = artifacts.require("Documents");

module.exports = function (deployer) {
  deployer.deploy(Documents, web3.utils.keccak256("replace with a long random key"),"ipfs://metadata");
};