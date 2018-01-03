pragma solidity ^0.4.4;

contract BloodChainStorage {

   struct BloodDonation {
    address origin;
    uint amount;
    string bloodType;
    uint ageRange;
    uint date;
    uint historyLength;
    mapping (uint => address) history;
    mapping (uint => uint256) timestamps;
  }

  mapping (string => BloodDonation) donations;

  function BloodChainStorage() {
    // constructor
  }

  function newDonation(uint _amount, string _bloodType, uint _ageRange, string _uniqueID) {
    donations[_uniqueID] = BloodDonation(msg.sender, _amount, _bloodType, _ageRange, now, 0);
    donations[_uniqueID].history[donations[_uniqueID].historyLength] = msg.sender;
    donations[_uniqueID].timestamps[donations[_uniqueID].historyLength] = now;
    donations[_uniqueID].historyLength++;
    
  }

  function getOrigin(string _uniqueID) constant returns (address) {
    return donations[_uniqueID].origin;
  }

  function getAmount(string _uniqueID) constant returns (uint) {
    return donations[_uniqueID].amount;
  }

  function getBloodType(string _uniqueID) constant returns (string) {
    return donations[_uniqueID].bloodType;
  }

  function getAgeRange(string _uniqueID) constant returns (uint) {
    return donations[_uniqueID].ageRange;
  }

  function getDate(string _uniqueID) constant returns (uint) {
    return donations[_uniqueID].date;
  }

  function getHistory(string _uniqueID) constant returns (address[],uint256[]) {
    uint size = donations[_uniqueID].historyLength;
    address[] memory _history = new address[](size);
    uint256[] memory _timestamps = new uint256[](size);
    
    for (uint i = 0; i < donations[_uniqueID].historyLength; i++) { 
      _history[i] = donations[_uniqueID].history[i];
      _timestamps[i] = donations[_uniqueID].timestamps[i];
    }
    return (_history,_timestamps);
  }
}
