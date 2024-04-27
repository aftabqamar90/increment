// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Counter {
    uint private counter; 
    address private  owner;
    constructor() {
        counter = 1;
        owner = msg.sender;
    }
    
    event Increment(uint value);
    event Decrement(uint value);

    function increment () public  {
        counter++;
        emit  Increment(counter);
    }

    function decrement() public {
        counter--;
        emit Decrement(counter);
    }

    function GetCounter()public view returns(uint)
    {
        return  counter;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "onlyOwner");
        _;
    }
}