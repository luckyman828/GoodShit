//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract GOODSHIT is ERC20, Ownable {

    address ownerAddress = 0x70148f215541fc4a64E308710a0e36512769115e;

    constructor() ERC20("GOODSHIT", "GOODSHIT") {
        _mint(ownerAddress, 1000000000 * (10 ** 18));
        transferOwnership(ownerAddress);
    }
    
}