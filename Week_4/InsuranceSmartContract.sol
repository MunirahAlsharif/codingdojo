//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

/**
 * @title Tech Insurance tor
 * @dev 
 * Step1: Complete the functions in the insurance smart contract
 * Step2:Add any required methods that are needed to check if the function are called correctly, 
 * and also add a modifier function that allows only the owner can run the changePrice function.
 * Step3: Add any error handling that may occur in any function
 * Step4: Add a modifer function to check the time if the client insurance is valid.
 * Step5 (opcional): Add a refund function that refunds money back to the client after one week. Guaranteed Money Back Plan.  
 * Step6: implement ERC 721 Token to this contract and change what it needs to be changed. 
 * 
 */
contract TechInsurance is ERC721("NinjaToekn","Ninja") {
    
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
    mapping(address => uint256) public _balances;
    mapping(uint => Product) public productIndex;
    mapping(address => mapping(uint => Client)) public client;
    
    uint productCounter;
    address  insOwner;
    constructor() public{
    insOwner = msg.sender;}
 
    function addProduct(uint _productId, string memory _productName, uint _price ) public {
        Product memory NewProduct = Product (_productId , _productName , _price , true);
        productIndex [productCounter ++] = NewProduct;
    }
     function mint(address to , uint256 tokenId)public  {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
        _beforeTokenTransfer(address(0), to, tokenId);
        _balances[to] += 1;
        _owners[tokenId] = to;

        emit Transfer(address(0), to, tokenId);
    }
    function doNotOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"No Offer");
        return productIndex[_productIndex].offered = false;
    }
    function forOffer(uint _productIndex) public returns(bool) {
        require(msg.sender == insOwner,"Yes Offer");
        return productIndex[_productIndex].offered = true;

    }
    function changePrice(uint _productIndex, uint _price) public view {
        require( productIndex[_productIndex].price>=1);
        productIndex[_productIndex].price==_price;
    }
    /**
    *@dev 
    * Every client buys an insurance, 
    * you need to map the client's address to the id of product to struct client, using (client map)
    */
    function buyInsurance(uint _productIndex) public payable {
        require(productIndex[_productIndex].price == msg.value ,"Not correct");
        Client memory NewClient;
        NewClient.isValid=true;
        NewClient.time = block.number;
        client[msg.sender][_productIndex]= NewClient;
        uint price= msg.value;
        payable(msg.sender).transfer(msg.value);
        
    } 
    function balanceOf(address insOwner) public view override returns(uint256) {
        require(insOwner != address(0));
        return _balances[insOwner];
        
    }
    
    function transferID( address to, uint256 tokenId) public  {
        //solhint-disable-next-line max-line-length
        require(ownerOf(tokenId) == msg.sender,"only owner" );
        require(to != address(0), "address to not 0 ");
        _transfer(msg.sender, to, tokenId);
    }
    
}
