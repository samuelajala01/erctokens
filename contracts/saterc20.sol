// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SAToken is ERC20, Ownable {
  
  uint256 public rate = 1000;
  uint FixedSupply;

 mapping(address => uint) balances;

 modifier sufficientBalance(address _spender, uint _value){
    require(_value > 0);
    require(_value <= balances[_spender] , "Insufficient Balance for User");
    _;
  }

  modifier validAddress(address _address){
    require(_address != address(0), "Invalid address");
    _;
  }


    constructor() ERC20("SAToken", "SAT") {
        _mint(msg.sender, 1000000 * 10 ** decimals());
        FixedSupply = 1000000 * 10 ** 18;
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function buyToken(address payable receiver, uint _value) public validAddress(receiver) sufficientBalance(receiver, _value)payable {
      uint amountToBuy = msg.value * rate;
      _mint(receiver, amountToBuy); 
      balances[msg.sender] -= _value;
      balances[receiver] += _value;
    }
}
