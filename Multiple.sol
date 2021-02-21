pragma solidity >=0.7.0 <0.8.0;

contract CountMultiple{
    
    function MultipleNM(uint8 N , uint8 M ) public pure returns(bool) {
        if (N % M == 0){
            return true;
        }
        else{
            return false;
        }
    }
    function MaxNum(uint8 N, uint8 M) public pure returns(uint8){
        if (N > M){
            return N;
        }
        else {
            return M;
        }
    }
}
