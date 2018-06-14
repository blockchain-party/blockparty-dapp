//THIS SMART CONTRACT IS CONSUMING A LOT OF GAS
//THIS IS DEMONSTRATION OF RANDOM NUMBER GENERATOR
//DO NOT USE IT FOR PRODUCTION

pragma solidity ^0.4.8;

contract Lottery {
    
    mapping (uint8 => address[]) playersByNumber ;
    
    address owner;
    
    function Lottery() public {
        owner = msg.sender;
        state = LotteryState.Accepting;
    }
    
    enum LotteryState { Accepting, Finished }
    
    LotteryState state; 
    
    function enter(uint8 number) public payable {
        require(number<=250);
        require(state == LotteryState.Accepting);
        require(msg.value > .001 ether);
        playersByNumber[number].push(msg.sender);
    }
    
    function determineWinner() public {
        require(msg.sender == owner);
        
        state = LotteryState.Finished;
        
        uint8 winningNumber = random();
        
        distributeFunds(winningNumber);

        selfdestruct(owner);
    }
    
    function distributeFunds(uint8 winningNumber) private returns(uint256) {
        uint256 winnerCount = playersByNumber[winningNumber].length;
                require(winnerCount == 1);
        if (winnerCount > 0) {
            uint256 balanceToDistribute = this.balance/(2*winnerCount);
            for (uint i = 0; i<winnerCount; i++) {
                require(i==0);
                playersByNumber[winningNumber][i].transfer(balanceToDistribute);
            }
        }
        
        return this.balance;
    }
    
    function random() private view returns (uint8) {
        return uint8(uint256(keccak256(block.timestamp, block.difficulty))%251);
    }
}
