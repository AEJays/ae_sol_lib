// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './Permission_interface.sol';
abstract contract permission{
    IPermission public Perm;
    address permissionAddress;
    // 合约是否为所有者
    modifier _owner{
        Perm._Owner();
        _;
    }
    // 信息调用者是否为所有者
    modifier isOwner(address user){
        Perm._IsOwner(user);
        _;
    }
    // 合约是否为管理员
    modifier _admin() {
        Perm._Admin();
        _;
    }
    // 信息调用者是否为管理员
    modifier isAdmin(address user){
        Perm._IsAdmin(user);
        _;
    }
    // 合约是否为封禁对象
    modifier _ban(){
        Perm._Ban();
        _;
    }
    // 信息调用者是否为封禁对象
    modifier isBan(address user){
        Perm._IsBan(user);
        _;
    }
    // 合约是否为数据库操控者
    modifier _sql(){
        Perm._Sql();
        _;
    }
    // 信息调用者是否为数据库操控者
    modifier isSql(address user){
        Perm._IsSql(user);
        _;
    }
    function setPermissioin(address _address) internal{
        Perm = IPermission(_address);
    }
}