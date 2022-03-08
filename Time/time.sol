// SPDX-License-Identifier: MIT
/* 
    时间库：
    现有方法：
    formatHms(uint timestamp) 
    返回值：
    uint[] 1：时 2：分 3：秒
 */
pragma solidity ^0.8.0;

library timeStamp {
    function formatHms(uint timestamp) internal pure returns (uint[] memory time){
        uint H = uint(timestamp / 60 / 60);
        uint m = uint((timestamp / 60) - H * 60);
        uint s = uint(timestamp - m * 60 - H * 60 * 60);
        time[1] = H;
        time[2] = m;
        time[3] = s;
    }
}