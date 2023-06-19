pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract SecondaryMarket {
    IERC20 public ticketToken;

    struct Offer {
        address seller;
        uint256 price;
        uint256 amount;
    }

    Offer[] public offers;

    constructor(address ticketTokenAddress) {
        ticketToken = IERC20(ticketTokenAddress);
    }

    function sellTicket(uint256 amount, uint256 price) public {
        require(ticketToken.transferFrom(msg.sender, address(this), amount), "Transfer failed");
        offers.push(Offer(msg.sender, price, amount));
    }

    function buyTicket(uint256 offerId) public payable {
        Offer storage offer = offers[offerId];
        require(msg.value >= offer.price, "Not enough ETH sent");

        if (msg.value > offer.price) {
            payable(msg.sender).transfer(msg.value - offer.price);
        }

        require(ticketToken.transfer(msg.sender, offer.amount), "Transfer failed");
        payable(offer.seller).transfer(offer.price);
        delete offers[offerId];
    }
}
