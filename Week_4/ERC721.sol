pragma solidity >=0.7.0 < 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";

contract MyToken is ERC721 {
    
    constructor () public ERC721("dojo","DOJO20"){
       // _mint(msg.sender, 1000000000 *(10 ** (decimals())));
        
    }
}