pragma solidity >=0.7.0 <0.8.0;

contract TechInsurance {
    
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
       productIndex [productCounter ++] = NewProduct;
 
    }
    
    
    function changeFalse(uint _productIndex) public {

    }
    
    function changeTrue(uint _productIndex) public {

    }
    
    function changePrice(uint _productIndex, uint _price) public {

    }
    
    function clientSelect(uint _productIndex) public payable {
        
    } 
    
}