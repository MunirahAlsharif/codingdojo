
pragma solidity >=0.7.0 <0.8.0;

contract Bank{
    
    int Balance;

    constructor () public {
         Balance= 100;
    }
    function GetBalance() view public returns(int){
        return Balance;
    }
    function withdraw(int amount) public{
        Balance = Balance - amount;
    }
    function deposit(int amount) public{
        Balance = Balance + amount;
    }
}