//SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
contract TechInsurance{
    /** 
     *Defined two structs one for (Product) other for (Client)
     */
    struct Product {
        uint product_Id;
        string product_Name;
        uint product_Price;
        bool GivenOffered;
        address Product_Owner_Address;
        address buyer_Address;
        }
    
    struct Client {
        bool isValid;
        uint time;
    }
    
    //here two event one for Product other for refund, use event to emit
    event productLoaded(uint product_Id,string product_Name, uint product_Price,bool GivenOffered);
  
    //here list of mapping
     mapping(address=> uint256) public MownedProduct;
     mapping (uint256 => address) public MOwners;
     mapping(uint => Product) public MproductIndex; // map the productCounter to a Product
     mapping(address => uint256) public MBalances;
      
    //here constructor & Function Modifier
    //constructor() public { owner = msg.sender; }
    
    address payable owner;
    
    modifier onlyOwner {
        require( msg.sender == owner,"Only owner can call this function." );
              _;}
              
    function ownerOf(uint256 _tokenId) public view  returns (address Owner) {
        Owner = MOwners[_tokenId];
        require(Owner != address(0));
        return Owner;
    }
    
    function balanceOf(address _InsuranceOWner) public view  returns(uint256) {
        require(_InsuranceOWner != address(0));
        return MBalances[owner];
    }
    
    function _mint(address _to, uint256 _tokenId) public{
        MOwners[_tokenId]=_to;
        MownedProduct[_to] +=1;
    }
    
    uint productCounter;    
    
    function addProduct(uint _productId, string memory _productName, uint _price ) public onlyOwner {
        productCounter++;
        MproductIndex [productCounter] = Product (_productId , _productName , _price , true, msg.sender, address(0));
        _mint(msg.sender,productCounter);
        emit productLoaded(_productId,_productName,_price,true);
    }
    
    function doNotOffer(uint _productIndex) public onlyOwner returns(bool) {
        return MproductIndex[_productIndex].GivenOffered = false;
    }
    
    function forOffer(uint _productIndex) public onlyOwner returns(bool) {
       return MproductIndex[_productIndex].GivenOffered = true;
    }
    
    function buyInsurance(uint _productIndex) public payable {
      address buyer =msg.sender;
      require(msg.value >= MproductIndex[_productIndex].product_Price ,"check the price of the Product");
      uint256 price = MproductIndex[_productIndex].product_Price;
      MproductIndex[_productIndex].buyer_Address = buyer; // update buyer address
      payable(MproductIndex[_productIndex].Product_Owner_Address).transfer(price);
      MproductIndex[_productIndex].Product_Owner_Address = buyer;
    }
    
    function changePrice(uint _productIndex, uint _NewPrice) public onlyOwner view {
        require( MproductIndex[_productIndex].product_Price>=1);
        MproductIndex[_productIndex].product_Price==_NewPrice;
    } 
    
    function transferID( address to, uint256 tokenId) public onlyOwner {
        //solhint-disable-next-line max-line-length
        require(to != address(0), "address to not 0 ");
        _transfer(msg.sender, to, tokenId);
     }
    
    function _transfer(address from, address to, uint256 tokenId) public onlyOwner  {
        require(to != address(0), "ERC721: transfer to the zero address");
        MBalances[from] -= 1;
        MBalances[to] += 1;
        MOwners[tokenId] = to;
    }
    
    //function Refund(address to, uint256 value)public onlyOwner returns(bool){
        //transfer funds from Refund account to owner }
        
    function Fatch(uint _productId)public view returns(uint product_Id ,string memory product_Name,uint product_Price, bool GivenOffered ,address owneer,address buyer){
      product_Id =MproductIndex [_productId].product_Id;
      product_Name =MproductIndex [_productId].product_Name;
      product_Price = MproductIndex[_productId].product_Price;
      GivenOffered = MproductIndex[_productId].GivenOffered;
      owneer = MproductIndex[_productId].Product_Owner_Address;
      buyer = MproductIndex[_productId].buyer_Address;  
    } 
   
    
    
    
    
    
}