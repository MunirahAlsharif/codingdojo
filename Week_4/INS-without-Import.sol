//SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.1;
contract TechInsurance{
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
    mapping (uint256 => address) public _owners;
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
    function balanceOf(address insOwner) public view  returns(uint256) {
        require(insOwner != address(0));
        return _balances[insOwner];
        
    }
     function ownerOf(uint256 tokenId) public view  returns (address) {
        address owner = _owners[tokenId];
        require(owner != address(0), "ERC721: owner query for nonexistent token");
        return owner;
    }
     function transferID( address to, uint256 tokenId) public  {
        //solhint-disable-next-line max-line-length
        require(ownerOf(tokenId) == msg.sender,"only owner" );
        require(to != address(0), "address to not 0 ");
        _transfer(msg.sender, to, tokenId);
    }
     function _transfer(address from, address to, uint256 tokenId) public  {
        require(ownerOf(tokenId) == from, "ERC721: transfer of token that is not own");
        require(to != address(0), "ERC721: transfer to the zero address");

        _beforeTokenTransfer(from, to, tokenId);

        _balances[from] -= 1;
        _balances[to] += 1;
        _owners[tokenId] = to;

       // emit Transfer(from, to, tokenId);
    }
    
    function mint(address to , uint256 tokenId)public  {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");
        _beforeTokenTransfer(address(0), to, tokenId);
        _balances[to] += 1;
        _owners[tokenId] = to;

        //emit transfer(address(0), to, tokenId);
    }
     function _exists(uint256 tokenId) public view  returns (bool) {
        return _owners[tokenId] != address(0);
    }
     function _beforeTokenTransfer(address from, address to, uint256 tokenId) public { }
    
}