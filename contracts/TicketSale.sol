pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TicketSale is ERC20 {
    constructor(uint256 initialSupply) ERC20("TicketToken", "TKT") {
        _mint(msg.sender, initialSupply);
    }

    function buyTicket(address buyer, uint256 amount) public {
        _transfer(msg.sender, buyer, amount);
    }
}
