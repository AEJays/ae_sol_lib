// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Token {
    function uniswapV2Pair() external view return (address);
}
interface PancakeLPs {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

library TokenPrice{
    // USDT对应的某个token的币价
    function usdtToTokenPrice(address _token) public returns(uint tokenPrice){
        Token aToken = Token(_token);
        address pairAddress = aToken.uniswapV2Pair()
        PancakeLPs LP = PancakeLPs(pairAddress)
        {uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast} = LP.getReserves
        tokenPrice = uint(reserve0 / reserve1)
    }
}