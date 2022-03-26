// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPermission {
    struct bannerType{
        string _type;
        address banner;
        uint startTime;
        uint endTime;
        bool isBan;
    }
    function setOwner(address _owner) external payable;
    function getOwner() external view returns (address _owner);
    function setAdmin(address _admin) external payable;
    function removeAdmin(address _admin) external payable;
    function setBanner(address _banner) external payable;
    function removeBanner(address _banner) external payable;
    function setTempBanner(address _banner,uint _startTime,uint _endTime) external payable;
    function removeTempBanner(address _banner) external payable;
    function getBanner() external view returns (bannerType[] memory banners);
    function setSql(address dataBaser) external payable;
    function rmSql(address dataBaser) external payable;
    function _Owner() external view;
    function _Ban() external view;
    function _Admin() external view;
    function _Sql() external view;
    function _IsOwner(address _user) external view;
    function _IsBan(address _user) external view;
    function _IsAdmin(address _user) external view;
    function _IsSql(address _user) external view;
}