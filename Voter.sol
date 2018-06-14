
pragma solidity ^0.4.18;
// We have to specify what version of compiler this code will compile with

contract Voting {
  /* mapping field below is equivalent to an associative array or hash.
  The key of the mapping is event name stored as type bytes32 and value is
  an unsigned integer to store the vote count
  */

  mapping (bytes32 => uint8) public votesReceived;

  /* Solidity doesn't let you pass in an array of strings in the constructor (yet).
  We will use an array of bytes32 instead to store the list of events
  */

  bytes32[] public eventList;

  /* This is the constructor which will be called once when you
  deploy the contract to the blockchain. When we deploy the contract,
  we will pass an array of events who will be contesting in the election
  */
  function Voting(bytes32[] eventNames) public {
    eventList = eventNames;
  }

  // This function returns the total votes a event has received so far
  function totalVotesFor(bytes32 event) view public returns (uint8) {
    require(validevent(event));
    return votesReceived[event];
  }

  // This function increments the vote count for the specified event. This
  // is equivalent to casting a vote
  function voteForevent(bytes32 event) public {
    require(validevent(event));
    votesReceived[event] += 1;
  }
  // This function checks if the event is in the eventlist.
  function validevent(bytes32 event) view public returns (bool) {
    for(uint i = 0; i < eventList.length; i++) {
      if (eventList[i] == event) {
        return true;
      }
    }
    return false;
  }
}
