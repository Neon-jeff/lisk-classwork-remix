// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

contract Ownable{
    address owner;
    constructor(){
        owner = msg.sender;
    }
   modifier onlyOwner {
        require(msg.sender == owner,"Ownable: transaction sender must be the owner");
        _;
    }

}


contract VotingSystem is Ownable{
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping (uint => Candidate) candidates;
    uint[] candidateIDs;
    mapping (address => bool) voters;

    event newCandidateAdded(uint id, string message);

    modifier voteOnce {
        require(!voters[msg.sender], 'You have already voted');
        _;
    }

    modifier validCandidateID (uint id) {
        require(id != 0 && id<=candidateIDs.length, 'Invalid candidate ID');
        _;
    }

    function addCandidate(string calldata _name) onlyOwner public  {
        uint newID = candidateIDs.length +1;
        candidates[newID] = Candidate(newID, _name,0);
        candidateIDs.push(newID);
        emit newCandidateAdded(newID, "New candidate added");
        
    }

    function vote (uint _id) voteOnce validCandidateID(_id) public {
        Candidate memory _candidate  = candidates[_id];
        _candidate.voteCount++;
        candidates[_id]=_candidate;
        voters[msg.sender] = true;
    }

    function getCandidate(uint _candidateID) validCandidateID(_candidateID) public view returns (string memory , uint){
        Candidate memory _candidate = candidates[_candidateID];
        return  (_candidate .name, _candidate .voteCount);
    }

    function getTotalCandidate() public view  returns (uint){
        return candidateIDs.length;
    }
    

}