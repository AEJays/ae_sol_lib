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
    // 默认0时区
    function getYMD(uint timestamp) internal pure returns(uint[3] memory time){
        return getYMD(timestamp,0);
    }
    // 求年月日
    function getYMD(uint timestamp,uint timeZone) internal pure returns(uint[3] memory time){
        timestamp = timestamp + timeZone * 1 hours; // UTC时区
        // 润年
        uint8[12] memory leapYear = [31,29,31,30,31,30,31,31,30,31,30,31];
        // 平年
        uint8[12] memory noleapYear = [31,28,31,30,31,30,31,31,30,31,30,31];
        uint totalDay = timestamp / 1 days;
        uint Year = 1970 + (totalDay / 365);
        bool isLeap;
        if(Year % 4 == 0&&Year%100!=0){
            isLeap = true;
        }else if(Year % 400 != 0&&Year%100 == 0){
            isLeap = false;
        }else if(Year % 400 == 0){
            isLeap = true;
        }else{
            isLeap = false;
        }
        uint Month;
        uint Day;
        uint tDay;
        bool isDay;
        if(isLeap){
            tDay = totalDay - ((Year-1970) * 366);
            for(uint i = 0;i<12;i++){
                if(tDay > leapYear[i]){
                    tDay -= leapYear[i];
                }else{
                    if(!isDay){
                        isDay = true;
                        Day = tDay;
                        Month = i + 1;
                    }
                }
            }
            if(Day<=12){
                time[2] = leapYear[Month-1] - (12 - Day);
            }else{
                time[2] = Day - 12;
            }
        }else{
            tDay = totalDay - ((Year-1970) * 365);
            for(uint i=0;i<12;i++){
                if(tDay > noleapYear[i]){
                    tDay -= noleapYear[i];
                }else{
                    if(!isDay){
                        isDay = true;
                        Day = tDay;
                        Month = i + 1;
                    }
                }
            }
            if(Day<=12){
                time[2] = noleapYear[Month-1] - (12 - Day);
            }else{
                time[2] = Day - 12;
            }
        }
        time[0] = Year;
        time[1] = Month;
    }
}