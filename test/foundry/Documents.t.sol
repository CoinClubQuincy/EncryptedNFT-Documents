// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Test.sol";
import "../../contracts/EncryptedNFTs.sol";

contract DocumentsTest is Test {
    address alice = makeAddr("alice");
    address bob = makeAddr("bob");
    bytes32 constant COMMITMENT = keccak256("a long random key");
    Documents d;

    function setUp() public {
        vm.prank(alice);
        d = new Documents(COMMITMENT, "ipfs://metadata");
    }

    function test_DeployerHoldsTheDocumentToken() public {
        assertEq(d.balanceOf(alice, d.Doc()), 1);
        assertEq(d.uri(0), "ipfs://metadata");
    }

    function test_ConstructorRequiresACommitment() public {
        vm.expectRevert("key commitment is required");
        new Documents(bytes32(0), "ipfs://metadata");
    }

    function test_VerifyKeyAcceptsOnlyTheRightKey() public {
        assertTrue(d.verifyKey(keccak256("a long random key")));
        assertFalse(d.verifyKey(keccak256("another key")));
    }

    function test_TheTokenCanBeSold() public {
        uint id = d.Doc();
        vm.prank(alice);
        d.safeTransferFrom(alice, bob, id, 1, "");
        assertEq(d.balanceOf(bob, id), 1);
        assertEq(d.balanceOf(alice, id), 0);
    }

    function test_StorageHoldsOnlyTheCommitment() public view {
        assertEq(vm.load(address(d), bytes32(uint256(3))), COMMITMENT);
        assertEq(d.viewKeyCommitment(), COMMITMENT);
    }

    function testFuzz_OnlyTheCommittedHashVerifies(bytes32 guess) public {
        vm.assume(guess != COMMITMENT);
        assertFalse(d.verifyKey(guess));
    }
}
