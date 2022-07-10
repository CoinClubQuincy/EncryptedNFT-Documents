const Documents = artifacts.require("Documents");

module.exports = function (deployer) {
  deployer.deploy(Documents, "keyName123","test1");
};