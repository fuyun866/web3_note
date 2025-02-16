// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract SimpleWallet {
    mapping(address => uint256) public balances;

    //只有在函数中声明了payable 才可以在函数内部访问msg.value

    function deposit() public payable {
        //msg.sender 返回调用该函数的账户地址
        balances[msg.sender] += msg.value;
    }

    function withDraw(uint256 amount) public {
        //条件校验
        require(balances[msg.sender] >= amount, "Insufficient funds.");
        //扣除用户存储在智能合约内部的余额
        balances[msg.sender] -= amount;
        //将余额发送到他们自己的钱包中，相当于提现
        payable(msg.sender).transfer(amount);
    }

    /**
     *view表示函数内部只能读取合约状态数据并不能进行更改
     */
    function checkBalances() public view returns (uint256) {
        return balances[msg.sender];
    }
}
