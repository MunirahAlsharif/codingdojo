//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;
contract CarExample{
    
    struct car {
        string NameCare;
        uint256 year;
        uint amount;
        bool isSold;
    }
    mapping(address => CarExample) public CarOwner;
    
    function addCar(string memory _name , uint256 _year , uint256 _amount) public pure{
        car memory NewCar = car (_name, _year, _amount,true);
        
        
    }
}