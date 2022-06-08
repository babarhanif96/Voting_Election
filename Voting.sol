pragma solidity ^0.8.7;

contract VotingContract{


// ======= struct=================

   struct Candidatedata{
        uint voting;
        address[]  Elector;
       
        
    }
  
   struct Vote {
       bool Isvooted;
       bool authorize;
  }

// ================mapping=====================

    mapping (string => Candidatedata) public Candidate ;
    mapping (address => Vote) public Voter ;

// ==============modifier=====================

 modifier OnlyOwner{
        require(msg.sender == owner, "Only owner can run this function");
        _;
    }



// =========variable===================
    address owner ;
   uint public TimeStampStart ; 
    uint public TimeStampEnd; 
    uint CandidateA = 0; 
    uint CandidateB = 0; 
    uint BlankVotes = 0; 
    uint NullVotes = 0; 
  
   
    bool Voting_start = false; 



// =============== functions=======================
    
    constructor() public  { 
       
       owner = msg.sender;
    }
    
    function StartVoting() public OnlyOwner { 
    
        TimeStampStart = block.timestamp; 
        Voting_start = true;
        
    }

    
 
    
    function Authorize ( address _voter) public OnlyOwner{
        Voter[ _voter].authorize = true; 
    }
 
    
  

    
    function Place_Vote(uint voto) public {
        require(Voting_start == true , "Voting is not start yet");


        require(Voter[msg.sender].authorize == true , " Only Authorize user can place vote" );
        require(Voter[msg.sender].Isvooted == false , "Already paid" );


       
            if(voto == 1){
                CandidateA++; 
                Candidate["A"].voting= Candidate["A"].voting +1;
                Candidate["A"].Elector.push(msg.sender);

            }
            else if(voto == 2){
                CandidateB++; 
                Candidate["B"].voting= Candidate["B"].voting +1;
                Candidate["B"].Elector.push(msg.sender);
            }
            else if(voto == 3){
                BlankVotes++; 
            }
            else{
                NullVotes++;
            }
      
         Voter[ msg.sender].Isvooted = true; 
    }

    
    function FinishVoting() public {
        TimeStampEnd = block.timestamp; 
        Voting_start = false ;
    }
    
      
    function Result_Printing() public view returns(uint _TimeStampStart, uint _TimeStampEnd, uint _CandidateA, uint _CandidateB, uint _BlankVotes, uint _NullVotes){ 

        return( 
                TimeStampStart,
                TimeStampEnd,
                CandidateA,
                CandidateB,
                BlankVotes,
                NullVotes);
        
    }
   
   
}
