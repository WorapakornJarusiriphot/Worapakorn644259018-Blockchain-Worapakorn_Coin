// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WorapakornToken is ERC20 {
    uint public exchangeRateForOneEther = 10;
    address public admin;

    event Buy(address indexed from, uint tokens);
    event ExchangeRateChanged(uint newRate);

    constructor() ERC20("WorapakornToken", "WKT") {
        _mint(address(this), 90000000 * 10 ** decimals());
        admin = msg.sender;
    }

    function buy() payable public {
        uint tokenReceived = msg.value * exchangeRateForOneEther;
        require(tokenReceived <= balanceOf(address(this)), "Not enough tokens");
        _transfer(address(this), msg.sender, tokenReceived);
        emit Buy(msg.sender, tokenReceived);
    }

    function setExchangeRate(uint newRate) public {
        require(msg.sender == admin, "Only admin can change the rate");
        exchangeRateForOneEther = newRate;
        emit ExchangeRateChanged(newRate);
    }

    function withdraw() public {
        require(msg.sender == admin, "Only admin can withdraw");
        payable(admin).transfer(address(this).balance);
    }
}
