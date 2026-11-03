pragma solidity ^0.8.10;
// SPDX-License-Identifier: MIT
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
interface Documents_interface{
    function viewKeyCommitment() external view returns(bytes32);
    function verifyKey(bytes32 _keyHash) external view returns(bool);
} 

/// @title An NFT tied to an encrypted document stored off-chain
/// @notice The contract never holds the decryption key, because anything in a contract can be
/// read by anyone. It stores a hash of the key, so a holder who is given the key off-chain can
/// confirm it is the right one. The token's URI points to the metadata and the encrypted file.
contract Documents is ERC1155, Documents_interface {
    uint256 public constant Doc = 0;
    bytes32 private keyCommitment;
    //launch contract
    constructor(bytes32 _keyCommitment, string memory URI) ERC1155(URI) {
        require(_keyCommitment != bytes32(0), "key commitment is required");
        keyCommitment = _keyCommitment;
        _mint(msg.sender, Doc, 1, "");
    }
    //anyone can read the commitment, since hiding it would hide nothing
    function viewKeyCommitment() public view returns(bytes32){
        return keyCommitment;
    }
    //check that a key's hash matches the commitment. Hash the key off-chain, so it is never sent to the chain
    function verifyKey(bytes32 _keyHash) public view returns(bool){
        return _keyHash == keyCommitment;
    }
}
