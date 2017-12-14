pragma solidity ^0.4.4;

contract MyCoin {

    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    mapping(address => uint256) public balance;

    event Transfer(address _from, address _to, uint256 _value);

    function MyCoin(string coinName, string sym, uint8 decimalPoint, uint256 initSupply){

        name = coinName;                    // Name of your newly created coin
        symbol = sym;                       // Symbol of your newly created coin
        decimal = decimalPoint;             // Define decimal point of your currency
        totalSupply = initSupply;           // In start total supply will be same as initial supply

        balance[msg.sender] = initSupply;   // Will assign all the initial supply to creator of currency
    }

    function transfer(address _to,uint256 _value){

        if(_to == address(0x0)) revert();            // Check for valid _to address
        if(balance[msg.sender] < _value) revert();   // Check if sender has enough balance

        balance[msg.sender] -= _value;               // Subtract from the balance of sender
        balance[_to]  += _value;                     // Add to the balance of receiver

        Transfer(msg.sender,_to,_value);             // Generate a transfer event for eventListeners and logging
    }

}