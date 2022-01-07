//SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract GOODSHIT is ERC20, Ownable {

    using SafeMath for uint256;
    mapping(address => mapping(address => uint256)) private _allowances;
    address ownerAddress = 0x99c88f928AA5A4C99DBc83C915aEDF51389DE16B;
    address liqAddress = 0xa36037dC26C5C02e864eBA969A312320E6487269;
    address marketAddress = 0x1c9dfEcC8321596Ac15af3E17364300275E01aCd;
    uint256 liqFee = 2;
    uint256 marketingFee = 3;

    constructor() ERC20("GoodShit.Holdings", "GOODSHIT") {
        _mint(ownerAddress, 1000000000 * (10 ** 18));
        transferOwnership(ownerAddress);
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        (uint256 liqTax, uint256 marketingTax, uint256 tTransferAmount) = _getValues(amount);
        _transfer(_msgSender(), liqAddress, liqTax);
        _transfer(_msgSender(), marketAddress, marketingTax);
        _transfer(_msgSender(), recipient, tTransferAmount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        (uint256 liqTax, uint256 marketingTax, uint256 tTransferAmount) = _getValues(amount);
        _transfer(sender, liqAddress, liqTax);
        _transfer(sender, marketAddress, marketingTax);
        _transfer(sender, recipient, tTransferAmount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function _getValues(uint256 amount) private view returns (uint256, uint256, uint256) {
        uint256 liqTax = amount.mul(liqFee).div(100);
        uint256 marketingTax = amount.mul(marketingFee).div(100);
        uint256 tTransferAmount = amount.sub(liqTax).sub(marketingTax);
        return (liqTax, marketingTax, tTransferAmount);
    }

    
    
}