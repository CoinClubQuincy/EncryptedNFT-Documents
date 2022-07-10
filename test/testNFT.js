const Documents = artifacts.require("Documents");

contract(Documents, (accounts) => {
    let eNFT = null;

    before( async() => {
        eNFT = await Documents.deployed("keyName123","test 1",{from: accounts[0]});
    });
    it("Launch NFT Document contract", async() =>  {
        assert(await eNFT.address !== '');
    })
    it("View data with token", async() =>  {
        let readKey = await eNFT.viewKey()
        assert(await readKey === "keyName123");
    })    
})