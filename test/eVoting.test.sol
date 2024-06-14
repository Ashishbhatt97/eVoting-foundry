// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

import "forge-std/Test.sol";
import "../src/eVoting.sol";

contract eVotingTest is Test {
    eVoting voting;
    address owner = address(this);

    function setUp() public {
        voting = new eVoting();
    }

    function testAddCandidate() public {
        assertEq(voting.candidateCount(), 0); //Initial candidate Count should be 0

        voting.addCandidate("Ashish Bhatt", "BJP"); //Adding candidate
        assertEq(voting.candidateCount(), 1);

        (string memory name, uint256 number, string memory _party) = voting
            .activeCandidates(0); // checking the added candidate details

        assertEq(name, "Ashish Bhatt");
        assertEq(_party, "BJP");
        assertEq(number, 1);

        //adding a candidate from a non owner address should be revert

        address nonOwner = address(0x000000458);
        vm.prank(nonOwner);
        vm.expectRevert("Only Owner can make changes");
        voting.addCandidate("Bob", "Party B");
    }



    function testVote() public {

    }
}
