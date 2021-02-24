pragma solidity >=0.7.0 < 0.8.1;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    
    constructor () public ERC20("dojo","DOJO20"){
       // _mint(msg.sender, 1000000000 *(10 ** (decimals())));
        
    }
}

