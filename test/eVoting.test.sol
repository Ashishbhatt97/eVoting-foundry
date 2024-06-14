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
        voting.addCandidate("ashish", "BJP");
        voting.addCandidate("ayush", "INC");

        assertEq(voting.votingCounts(), 0); //Checking initial voting counts in polling
        assertEq(voting.votes(1), 0); // checking 1st candidate's votes
        assertEq(voting.votes(2), 0); //checking 2nd candidate's votes

        //vote for candidate 1
        voting.vote(1);
        assertEq(voting.votes(1), 1);
        assertEq(voting.votingCounts(), 1);

        vm.expectRevert("you have already voted");
        voting.vote(2);
    }



    function testOwnershipOnlyOwnerCanAddCandidates() public {
    address nonOwner = address(0x05584EFd);
    vm.prank(nonOwner);
    vm.expectRevert("Only Owner can make changes");
    voting.addCandidate("Ashish Bhatt", "BJP");
    
    }
}
