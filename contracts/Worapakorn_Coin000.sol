// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WorapakornToken is ERC20 {
    uint exChangeRateForOneEther = 20;

    constructor() ERC20("WorapakornToken", "WKT") {    
        _mint(address(this), 90000000 * (10 ** decimals()));
    }

    function buy() payable public {
        uint tokenReceived = msg.value * exChangeRateForOneEther;
        require(tokenReceived <= balanceOf(address(this)), "Not enough tokens available");
        _transfer(address(this), msg.sender, tokenReceived);
    }
}
