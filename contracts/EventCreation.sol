pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./LensHandle.sol";

contract EventCreation is ERC721 {
    uint256 public eventId;
    LensHandle public lensHandle;

    struct Event {
        string name;
        string date;
        string location;
        address owner;
    }

    mapping(uint256 => Event) public events;

    constructor(address lensHandleAddress) ERC721("EventLens", "EVT") {
        lensHandle = LensHandle(lensHandleAddress);
    }

    function createEvent(string memory name, string memory date, string memory location) public {
        require(lensHandle.verifyHandle(msg.sender), "Invalid Lens Handle");

        events[eventId] = Event(name, date, location, msg.sender);
        _mint(msg.sender, eventId);
        eventId++;
    }
}
