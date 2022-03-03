// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library MathLib{
    /* 随机数方法
       传参说明:
       _number: 前端传入的随机数
       _length: 需要随机的长度 如：20则是20以下的所有随机数,不包括0
     */
    function Random(uint _number,uint8 _length) internal view returns(uint) {
        require(_length>256,"attribute _length must be less than or equal to 255");
        uint randomNum;
        // uint8 rand = uint8(uint(keccak256(abi.encodePacked(block.timestamp,safe,blockhash(block.number - 1)))));
        uint time = uint(keccak256(abi.encodePacked(block.timestamp - _number)));
        uint8 remain = uint8(time) % 100 % _length;
        uint8 divisor = uint8(time) / 100 % _length;
        if(remain > divisor){
            randomNum = remain;
        }else{
            randomNum = divisor;
        }
        if(randomNum == 0){
            uint t = Random(_number-1,_length);
            randomNum = (remain - divisor + t) % _length;
            if(randomNum == 0){
                randomNum = 1;
            }
        }
        return randomNum;
    }
}