
## 概览

## 版本说明

### v1.0.0 更新说明

### v1.0.1 更新说明

## 快速入门

### 安装或引入


`
pod install web3.swfit
`

### 初始化代码

```
let web3 = Web3(rpcURL: "http://localhost:6789")

```


## 秘钥/钱包管理（部分语言版本无实现）

### 秘钥生成
### 秘钥加载
### 生成keystore
### 导入keystore
### 导出keystore
### 私钥生成公钥，公钥生成地址等等等...
### 普通签名
### 普通签名验证
### 对交易进行签名
### 对交易进行签名验证
### hash方法等等等


## 合约


### 合约代码生成

    使用工具xxx
    
### 合约示例

```

```


#### 加载合约

#### 部署合约

#### 合约call调用

#### 合约sendRawTransaction调用

#### 合约event



## web3

### 基础API

#### 连接状态
#### 当前节点
#### 重置连接
#### 获取当前版本号



### web3 net (标准JSON RPC )


#### listening

**Parameters**

无

**Returns**


无

**Example**

```
web3.eth.ens.getAddress('ethereum.eth').then(function (address) {
    console.log(address);
})
0xfB6916095ca1df60bB79Ce92cE3Ea74c37c5d359
```


#### peerCount



### web3 Version 相关 (标准JSON RPC )
#### api(自身平台api)
#### node

获取当前客户端节点


#### network

获取当前网络协议版本号

#### ethereum（去掉？）

获取当前以太坊协议版本号

### web3 db相关 (标准JSON RPC )

#### putString
#### getString
#### putHex
#### getHex

### web3 eth相关 (标准JSON RPC )

#### getBalance

>查询账户余额

**参数**

| 类型  | 属性  | 含义 |
| :---------------: |:---------------:| :---------------:|
| String或byte[]      | 必选 | 账户地址 |


**返回值 或 回调**

账户余额

**示例**


```
web3.eth.getBalance(address: ea!, block: .latest) { resp in
        switch resp.status{
        case .success(_):
            NSLog("\(resp.result!.quantity)")
        case .failure(_):
            failCompletion()
        }
}
```

----


#### getStorageAt
#### getCode
#### getBlock
#### getUncle
#### getBlockTransactionCount
#### getBlockUncleCount
#### getTransaction
#### getTransactionFromBlock
#### getTransactionReceipt
#### getTransactionCount
#### call
#### estimateGas
#### sendRawTransaction
#### signTransaction
#### sendTransaction
#### sign
#### submitWork
#### getLogs
#### getWork


#### coinbase
#### mining
#### hashrate
#### syncing
#### gasPrice
#### accounts
#### blockNumber
#### protocolVersion

#### newFilterCall
#### uninstallFilter
#### getFilterLogs
#### getFilterChanges

### web3 personal (标准JSON RPC )

#### newAccount
#### importRawKey
#### unlockAccount
#### ecRecover
#### sign
#### sendTransaction
#### lockAccount

