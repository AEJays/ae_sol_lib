// SPDX-License-Identifier: MIT
/* 
    时间库：
    现有方法：
    formatHms(uint timestamp) 
    返回值：
    uint[] 0：时 1：分 2：秒
 */
pragma solidity ^0.8.0;

library timeStamp {
    // 求一天内的时分秒
    function formatTime(uint timestamp) internal pure returns (uint[3] memory time){
        timestamp = ((timestamp % (1 days * 365)) % (1 days * 30)) % 1 days;
        uint H = timestamp / 3600;
        timestamp = timestamp % 3600;
        uint m = timestamp / 60;
        timestamp = timestamp % 60;
        uint s = timestamp;
        // 增加时区
        H = H + 8; 
        if(H>=24){
            H = H - 24;
        }
        time[0] = H;
        time[1] = m;
        time[2] = s;
    }
}