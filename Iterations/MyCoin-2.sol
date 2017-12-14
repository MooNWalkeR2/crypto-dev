pragma solidity ^0.4.4;

contract MyCoin {

    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    mapping(address => uint256) public balance;

    function MyCoin(string coinName, string sym, uint8 decimalPoint, uint256 initSupply){

        name = coinName;                    // Name of your newly created coin
        symbol = sym;                       // Symbol of your newly created coin
        decimal = decimalPoint;             // Define decimal point of your currency
        totalSupply = initSupply;           // In start total supply will be same as initial supply

        balance[msg.sender] = initSupply;   // Will assign all the initial supply to creator of currency
    }

}