## Solidity lib
### 说明 
这是一个合约的lib库

安装方法
```bash
npm i git@202.43.232.79:AEdge/soliditylib.git --save
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
