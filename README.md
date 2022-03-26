## Solidity lib
### 说明 
这是一个合约的lib库

安装方法
```bash
npm i git@202.43.232.79:yuangke-team/soliditylib.git --save
```
引入方式
```sol
import 'solidity_lib/合约路径'
```
### 现有方法库

#### Math
引入方式:

在合约头增加以下代码

```sol
import 'solidity_lib/Math/MathLib.sol';
```
##### 已有方法

MathLib.Random(uint 前端传入的随机数,uint8 长度) 随机数
注意:传入的长度必须小于或等于100

#### timeStamp
引入方式

在合约头增加以下代码

```sol
import 'solidity_lib/Time/time.sol';
```
##### 已有方法

timeStamp.formatTime(uint 时间戳)
算今天的时分秒

##### 更新方法
```bash
npm i solidity_lib
```

#### Permission
引入方式

在合约头增加以下代码

```sol
import 'solidity_lib/Permission/Permission.sol';
```

继承权限库

```sol
contract xxx is Permission{
    // 默认不设置 owner 为0地址 需要在初始化时候设置所有者
    constructor(address owner){
        setOwner(owner);
    }
}
```

权限校验 

```sol
// 该方法只允许管理员使用 注意 所有者默认为管理员
function ff(address user) public payable isAdmin{
}
// 该方法只允许所有者使用
function ff(address user) public payable isOwner{
}
// 该方法只允许未被禁用的玩家使用
function ff(address user) public payable isBan{
}
```

现有方法

setOwner(address) 设置所有者 权限只开放给所有者

getOwner() 获取所有者 权限只开放给所有者

setAdmin(address) 设置管理员 权限只开放给所有者

removeAdmin(address) 删除管理员 权限只开放给所有者

setBanner(address) 设置永久禁用的地址 权限开放给所有者及管理员

removeBanner(address) 删除永久禁用的地址(解封) 类型需要对 权限开放给所有者及管理员

setTempBanner(address,uint,uint) 设置临时禁用的地址 需要设置开始时间至结束时间 权限开放给管理员

removeTempBanner(address) 删除临时禁用的地址(解封) 类型需要对

getBanner() 获取封禁列表 isBan 为true时 表示已被封禁 为false表示已解禁 

setSql(address) 设置数据库人员

rmSql(address) 删除数据库人员
### 权限库已统一

直接使用 Permission_abstract.sol 文件

#### 引入方式
```sol
import 'solidity_lib/Permission/Permission_abstract.sol'
// 继承即可
contract a is permission {
```

使用前需要在构造函数中设置公共权限库地址

完整引入例子如下

```sol
import 'solidity_lib/Permission/Permission_abstract.sol'
contract a is permission{
    constructor(address permissionAddress){
        setPermission(permissionAddress);
    }
    address user;
    <!-- 如果某个方法需要管理员权限 则用法如下 所有者默认为管理员 -->
    function setUser(address _user) public payable isAdmin(msg.sender){
        user = _user;
    }
    <!-- 如果某个方法需要所有者权限 则用法如下 -->
    function getUser() public view returns isOwner(msg.sender) (address _user){
        return user;
    }
    <!-- 如果某个方法需要数据库人员权限 则用法如下 -->
    function getUser() public view returns isSql(msg.sender) (address _user){
        return user;
    }
    <!-- 如果某个方法需要不被封禁的人员权限 则用法如下 -->
    function getUser() public view returns isBan(msg.sender) (address _user){
        return user;
    }
    <!-- isBan权限可以和以上的任何方法一起用 -->
    <!-- 如果某个方法需要合约自身为管理员权限，则用法如下 -->
    function getUser() public view returns _admin (address _user){
        return user;
    }
    <!-- 如果某个方法需要合约自身为所有者权限，则用法如下 -->
    function getUser() public view returns _owner (address _user){
        return user;
    }
    <!-- 如果某个方法需要合约自身为不被封禁的人员权限，则用法如下 -->
    function getUser() public view returns _ban (address _user){
        return user;
    }
    <!-- 如果某个方法需要合约自身为数据库操控者的人员权限，则用法如下 -->
    function getUser() public view returns _sql (address _user){
        return user;
    }
}
```

[权限库依赖代码](http://202.43.232.79:9099/yuangke-team/permission_solidity)