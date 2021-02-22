pragma solidity >=0.7.0 <0.8.0;

contract MappExample{
    
    mapping(string => string) citys;
    
    function storeCity (string memory City, string memory Country) public{
       
        citys[City] = Country ;
        
    }
    
    function returnsValue (string memory N_country) public view returns(string memory){
        
        return citys[N_country];
    }
}