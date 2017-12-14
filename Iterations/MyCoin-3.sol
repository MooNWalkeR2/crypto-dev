pragma solidity ^0.4.4;

contract MyCoin {

    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply;

    mapping(address => uint256) public balance;

    event Transfer(address indexed _from, address _to, uint256 _value);
    event Burn(address indexed _caller, uint256 _value);

    function MyCoin(string coinName, string sym, uint8 decimalPoint, uint256 initSupply){

        name = coinName;                    // Name of your newly created coin
        symbol = sym;                       // Symbol of your newly created coin
        decimal = decimalPoint;             // Define decimal point of your currency
        totalSupply = initSupply;           // In start total supply will be same as initial supply

        balance[msg.sender] = initSupply;   // Will assign all the initial supply to creator of currency
    }

    function transfer(address _to,uint256 _value) returns (bool){

        if(_to == address(0x0)) revert();            // Check for valid _to address
        if(balance[msg.sender] < _value) revert();   // Check if sender has enough balance

        balance[msg.sender] -= _value;               // Subtract from the balance of sender
        balance[_to]  += _value;                     // Add to the balance of receiver

        Transfer(msg.sender,_to,_value);             // Generate a transfer event for eventListeners and logging
        return true;
    }

    function burn(uint256 _value) returns (bool){

        if(balance[msg.sender] < _value) revert();    // Check if the caller has enough balance
        balance[msg.sender] -= _value;                // Subtract value from caller's balance
        totalSupply -= _value;                        // Subtract value from total supply
        Burn(msg.sender,_value);                      // Generate a burn event for eventListeners and logging
        return true;
    }

    function checkBalance() returns (uint256){
        return balance[msg.sender];                    // Return the balance of caller
    }

}