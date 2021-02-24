//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract TechInsurance is ERC721 {
    
    /** 
     * Defined two structs
     * 
     * 
     */
    struct Product {
        uint productId;
        string productName;
        uint price;
        bool offered;
    }
     
    struct Client {
        bool isValid;
        uint time;
    }
    
    
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    uint productCounter;
    
    address payable insOwner;
    constructor(address payable _insOwner) public{
        insOwner = _insOwner;
    }
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
       Product memory NewProduct = Product (_productId , _productName , _price , true);
       insOwner [msg.sender]= NewProduct;
       productIndex [productCounter ++] = NewProduct;
 
    }
    
    
    function changeFalse(uint _productIndex) public {
       require (msg.value == productIndex[_productIndex]).changeFalse[offered]=false;
    }
    
    function changeTrue(uint _productIndex) public {
       require (msg.value == productIndex[_productIndex]).changeTrue[offered]=true;

    }
    
    function changePrice(uint _productIndex, uint _price) public {
       require (msg.value == productIndex[_productIndex].changePrice=_price);
    }
    
    function clientSelect(uint _productIndex) public payable {
        
    } 
    
}