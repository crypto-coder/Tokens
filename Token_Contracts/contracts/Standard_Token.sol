/*Most, basic default, standardised Token contract.
Allows the creation of a token with a finite issued amount to the creator.

Based on standardised APIs: https://github.com/ethereum/wiki/wiki/Standardized_Contract_APIs
.*/

import "Token";

contract Standard_Token is Token {

    function Standard_Token(uint256 _initial_amount) {
        balances[msg.sender] = _initial_amount;
        total_supply = _initial_amount;
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        if (balances[msg.sender] >= _value) {
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            Transfer(msg.sender, _to, _value);
            return true;
        } else { return false; }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balances[_from] >= _value && allowed[_from][_to] >= _value) {
            balances[_from] -= _value;
            balances[_to] += _value;
            allowed[_from][_to] -= _value;
            Transfer(_from, _to, _value);
            return true;
        } else { return false; }
    }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function unapprove(address _spender) returns (bool success) {
        allowed[msg.sender][_spender] = 0;
        //todo: insert correct event after community has decided upon it.
    }

    function approve(address _spender, uint256 _value) returns (bool success) {
        allowed[msg.sender][_spender] += _value;
        Approval(msg.sender, _spender, _value);
        return true;
    }


    function totalSupply() constant returns (uint256 _total) {
        return total_supply;
    }

    mapping (address => uint) balances;
    mapping (address => mapping (address => uint256)) allowed;
    uint256 total_supply;
}