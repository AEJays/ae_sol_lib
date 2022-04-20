// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Permission{
    address owner; //所有者 默认为合约本身
    struct bannerMes {
        uint startTime;
        uint endTime;
    }
    struct bannerType{
        string _type;
        address banner;
        uint startTime;
        uint endTime;
        bool isBan;
    }
    mapping(address=>bool) admins; //管理员组校验
    mapping(address=>bool) isBanner; //是否被ban了
    mapping(address=>bannerMes) isTempBanner; //临时ban禁
    mapping(address=>bool) sql; //是否为数据库操作人员
    bannerType[] bannerGroup;
    modifier isOwner(){
        require(msg.sender == owner||owner == address(0),"You don't have permission");
        _;
    }
    modifier isBan(){
        if(isBanner[msg.sender]){
            revert("You are permanently banned");
        }else if(isTempBanner[msg.sender].startTime<=block.timestamp&&isTempBanner[msg.sender].endTime>=block.timestamp){
            revert("You have been temporarily banned");
        }
        _;
    }
    // 所有者默认包含owner
    modifier isAdmin(){
        require(admins[msg.sender],"You are not an administrator");
        _;
    }
    modifier isSql(){
        require(sql[msg.sender],"You cannot manipulate the database");
        _;
    }
    modifier _isOwner(address user){
        require(user == owner||owner == address(0),"You don't have permission");
        _;
    }
    modifier _isBan(address user){
        if(isBanner[user]){
            revert("You are permanently banned");
        }else if(isTempBanner[user].startTime<=block.timestamp&&isTempBanner[user].endTime>=block.timestamp){
            revert("You have been temporarily banned");
        }
        _;
    }
    // 所有者默认包含owner
    modifier _isAdmin(address user){
        require(admins[user],"You are not an administrator");
        _;
    }
    modifier _isSql(address user){
        require(sql[user],"You cannot manipulate the database");
        _;
    }
    // 设置所有者
    function setOwner(address _owner) public payable isOwner{
        owner = _owner;
        admins[_owner] = true;
        sql[_owner] = true;
    }
    // 获取所有者
    function getOwner() public view isOwner returns (address _owner){
        return owner;
    }
    // 设置管理员 除了owner外的管理员 可执行ban禁玩家的操作 但不是权限所有者 只有所有者可设置
    function setAdmin(address _admin) public payable isOwner{
        admins[_admin] = true;
        sql[_admin] = true;
    }
    // 取消管理员 所有者才可设置
    function removeAdmin(address _admin) public payable isOwner{
        admins[_admin] = false;
        sql[_admin] = false;
    }
    // 设置永久ban禁地址
    function setBanner(address _banner) public payable isAdmin{
        isBanner[_banner] = true;
        bannerGroup.push(bannerType("permanent",_banner,block.timestamp,0,true));
    }
    // 解除永久ban禁
    function removeBanner(address _banner) public payable isAdmin{
        isBanner[_banner] = false;
        bool hasBanner = false;
        for(uint i = 0;i<bannerGroup.length;i++){
            if(bannerGroup[i].banner == _banner){
                hasBanner = true;
                if(keccak256(abi.encodePacked(bannerGroup[i]._type)) == keccak256(abi.encodePacked("permanent"))){
                     if(bannerGroup[i].isBan){
                        bannerGroup[i].isBan = false;
                    }else{
                        revert("Users are not banned");
                    }
                }else{
                    revert("Type of ban error");
                }
            }
        }
        if(hasBanner == false){
            revert("Players are not on the ban list");
        }
    }
    // 获取临时ban禁的地址及时间
    function setTempBanner(address _banner,uint _startTime,uint _endTime) public payable isAdmin{
        isTempBanner[_banner] = bannerMes(_startTime,_endTime);
        bannerGroup.push(bannerType("temporary",_banner,_startTime,_endTime,true));
    }
    // 解除临时ban禁
    function removeTempBanner(address _banner) public payable isAdmin{
        isTempBanner[_banner] = bannerMes(0,0);
        bool hasBanner = false;
        for(uint i = 0;i<bannerGroup.length;i++){
            if(bannerGroup[i].banner == _banner){
                hasBanner = true;
                if(keccak256(abi.encodePacked(bannerGroup[i]._type)) == keccak256(abi.encodePacked("temporary"))){
                    if(bannerGroup[i].isBan){
                        bannerGroup[i].isBan = false;
                    }else{
                        revert("Users are not banned");
                    }
                }else{
                    revert("Type of ban error");
                }
            }
        }
        if(hasBanner == false){
            revert("Players are not on the ban list");
        }
    }
    // 获取所有ban禁地址
    function getBanner() public view isAdmin returns (bannerType[] memory banners){
        return bannerGroup;
    }
    // 设置数据库人员
    function setSql(address dataBaser) public payable isAdmin{
        sql[dataBaser] = true;
    }
    // 删除数据库人员
    function rmSql(address dataBaser) public payable isAdmin{
        sql[dataBaser] = false;
    }
}