
## 概览

## 版本说明

### v1.0.0 更新说明
发行初始版本

## 快速入门

### 安装或引入

通过CocoaPods引入, 在podfile文件添加：

`
pod install web3.swfit
`

### 初始化代码

```
let web3 = Web3(rpcURL: "http://localhost:6789")

```


## 合约

合约部署和调用需要xx工具生成abi（应用程序二进制接口）和bin（WebAssembly的二进制代码），参考[生成方法]()。
    
### 合约示例

```
namespace platon {
    class ACC : public token::Token {
    public:
        ACC(){}
        void init(){
            Address user(std::string("0xa0b21d5bcc6af4dda0579174941160b9eecb6916"), true);
            initSupply(user, 199999);
        }

        void create(const char *addr, uint64_t asset){
            Address user(std::string(addr), true);
            Token::create(user, asset);
        }

        uint64_t getAsset(const char *addr) const {
            Address user(std::string(addr), true);
            return Token::getAsset(user);
        }

        void transfer(const char *addr, uint64_t asset) {
            Address user(std::string(addr), true);
            Token::transfer(user, asset);
        }
    };
}

PLATON_ABI(platon::ACC, create)
PLATON_ABI(platon::ACC, getAsset)
PLATON_ABI(platon::ACC, transfer)
//platon autogen begin
extern "C" { 
    void create(const char * addr,unsigned long long asset) {
        platon::ACC ACC_platon;
        ACC_platon.create(addr,asset);
    }
    unsigned long long getAsset(const char * addr) {
        platon::ACC ACC_platon;
        return ACC_platon.getAsset(addr);
    }
    void transfer(const char * addr,unsigned long long asset) {
        platon::ACC ACC_platon;
        ACC_platon.transfer(addr,asset);
    }
    void init() {
        platon::ACC ACC_platon;
        ACC_platon.init();
    }
}
//platon autogen end
```


#### 部署合约

**接口声明**

```
func platonDeployContract(abi : String,
                          bin : Data,
                          sender : String,
                          privateKey : String,
                          gasPrice : BigUInt,
                          gas : BigUInt,
                          estimateGas : Bool,
                          timeout: dispatch_time_t,
                          completion : ContractDeployCompletion?)
```

                              

| 名称  |类型| 属性  | 含义 |
| :---------------: | :----: |:---------------:| :---------------:|
| abi  |	 String     			    | 必选  | 应用程序二进制接口       |
| bin | 	Data					    | 必选  | WebAssembly的二进制代码 |
| sender |	 String  				    | 必选  | 账户地址 |
| privateKey |    String  			    | 必选 | 私钥 |
| gasPrice |  BigUInt    			    | 必选 | 手续费费用 |
| gas | BigUInt     			    | 必选 | 手续费 |
| estimateGas |  Bool    				    | 必选 | 是否预估手续费，如果为true，则根据abi和bin自动预估费用;否则使用接口传入的gasPrice， gas。 |
| timeout |  `dispatch_time_t`    		    | 必选 | 超时时间 |
| completion  |   ContractDeployCompletion   | 必选 | 完成回调 |




```
//get gas via web3.eth.estimateGas
let gasPrice = BigUInt("22000000000")
let gas = BigUInt("4300000")
        
let binPath = Bundle.main.path(forResource: "PlatonAssets/multisig", ofType: "wasm")
let bin = try? Data(contentsOf: URL(fileURLWithPath: binPath!))

let abiPath = Bundle.main.path(forResource: "PlatonAssets/multisig.cpp.abi", ofType: "json")
var abiS = try? String(contentsOfFile: abiPath!)
abiS = abiS?.replacingOccurrences(of: "\r\n", with: "")
abiS = abiS?.replacingOccurrences(of: "\n", with: "")
abiS = abiS?.replacingOccurrences(of: " ", with: "")

web3.eth.platonDeployContract(abi: abiS!, bin: bin!, sender: sender, privateKey: privateKey, gasPrice: deployGasPrice, gas: deployGgas, estimateGas: false, timeout: 20, completion:{
(result,contractAddress,transactionHash) in
	switch result{
	case .success:
		do {
		}
	case .fail(let fret, let fdes):
		do {
		}
	}
})
```


#### 合约call调用

>调用合约函数，返回常量值

**接口声明**

```
func platonCall(contractAddress : String,
                 functionName : String,
                 from: String,
                 _ params : [Data],
                 outputs: [SolidityParameter],
                 completion : ContractCallCompletion?)
```
    
**参数说明**    

| 名称  |类型| 属性  | 含义 |
| :---------------: | :----: |:---------------:| :---------------:|
| contractAddress | String | 必选 | 应用程序二进制接口 |
| functionName | String | 必选 | WebAssembly的二进制代码 |
| from |	String | 必选 | 账户地址 |
| params | [Data] | 必选 | 合约对应接口的参数列表 |
| outputs | [SolidityParameter] | 必选 | 合约返回值 |
| completion | ContractCallCompletion | 必选 | 完成回调 |

**示例**

```
let paramter = SolidityFunctionParameter(name: "", type: .uint64)
let contractAddress = "0x..."
let owner = "0x..."
let ownerData = owner.data(using: .utf8)
web3.eth.platonCall(contractAddress: contractAddress, functionName: "getAsset", from: from, [ownerData], outputs: [paramter]) { (result, data) in
    switch result{        
    case .success:
	    do{}
    case .fail(let code, let errMsg):
         do{}
    }
}
```

#### 合约sendRawTransaction调用

>发送通过私钥签名的交易

**接口声明**

```
func plantonSendRawTransaction(contractAddress : String,
                               functionName : String,
                               _ params : [Data],
                               sender: String,
                               privateKey: String,
                               gasPrice : BigUInt,
                               gas : BigUInt,
                               estimated: Bool,
                               completion: ContractSendRawCompletion?)
```        
                       
**参数说明**    

| 名称  |类型| 属性  | 含义 |
| :---------------: | :----: |:---------------:| :---------------:|
| contractAddress | String | 必选 | 合约地址 |
| functionName | String | 必选 | 方法名 |
| params |	[Data] | 必选 | 调用参数列表 |
| sender |	 String | 必选  | 账户地址 |
| privateKey |    String | 必选 | 私钥 |
| gasPrice |  BigUInt | 必选 | 手续费费用 |
| gas | BigUInt | 必选 | 手续费 |
| estimateGas |  Bool | 必选 | 是否预估手续费，如果为true，则根据abi和bin自动预估费用;否则使用接口传入的gasPrice， gas。 |
| completion | ContractCallCompletion | 必选 | 完成回调 |

**示例**

```
let address = "0x..".data(using: .utf8)
let amout = Data(bytes: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02])
let gasPrice = BigUInt("22000000000")
let gas = BigUInt("4300000")
let sender = "0x60ceca9c1290ee56b98d4e160ef0453f7c40d219"
let privateKey = "4484092b68df58d639f11d59738983e2b8b81824f3c0c759edd6773f9adadfe7"
let contractAddress = "0x43355c787c50b647c425f594b441d4bd751951c1"
web3.eth.plantonSendRawTransaction(contractAddress: contractAddress, functionName: "transfer", [address!, amout], sender: sender, privateKey: privateKey, gasPrice: gasPrice!, gas: gas!,estimated: false, completion: { (result, data) in
    switch result{
    case .success:
        do{}
    case .fail(_,_):
        do{}
    }
})
```




## web3


### web3 eth相关 (标准JSON RPC )

#### getBalance

>查询账户余额

**接口声明**

```
public func getBalance(
    address: EthereumAddress,
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumQuantity>
)
```


**参数**


| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |


**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`

余额对应EthereumQuantity对象的quantity属性

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

#### getStorageAt

>获取某一地址上指定位置的存储数据

**接口声明**

```
public func getStorageAt(
    address: EthereumAddress,
    position: EthereumQuantity,
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumData>
)
```

**参数**


| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| position | Int      | 必选 | 存储索引地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumData>
`
EthereumData属性中的bytes即为对应存储数据

**示例**

```
web3.eth.getStorageAt(address: ea!, block: .latest) { resp in
        switch resp.status{
        case .success(_):
			do{}	
        case .failure(_):
			do{}
        }
}
```



#### getCode

>获取某一地址上指定位置的数据

**接口声明**

```
public func getCode(
    address: EthereumAddress,
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumData>
)
``` 


**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumData>
`

EthereumData即为对应数据


**示例**

```
 let address = EthereumAddress(hexString: "0x...")
 web3.eth.getCode(address: address!, block: .latest) { (result) in
     switch result.status{
         
     case .success(_):
         do{}
     case .failure(_):
         do{}
     } 
 }

```


#### getBlockByHash

>获取某一地址上指定位置的数据

**接口声明**

```
public func getBlockByHash(
    blockHash: EthereumData,
    fullTransactionObjects: Bool,
    response: @escaping Web3ResponseCompletion<EthereumBlockObject?>
    )
``` 

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumAddress      | 必选 | 区块哈希 |
| fullTransactionObjects | Int      | 必选 | 是否获取获取所有交易 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumBlockObject?>
`
EthereumBlockObject为对应结果

**示例**

```

let blockHash = EthereumData(bytes: (Data.init(hexStr: "0x...")?.bytes)!)
web3.eth.getBlockByHash(blockHash: blockHash, fullTransactionObjects: true) {  (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```


#### getBlockByNumber

>获取对应区块类型的区块内容

**接口声明**

```
public func getBlockByNumber(
    block: EthereumQuantityTag,
    fullTransactionObjects: Bool,
    response: @escaping Web3ResponseCompletion<EthereumBlockObject?>
)
``` 

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| block | EthereumQuantityTag      | 必选 | 区块类型 |
| fullTransactionObjects | Int      | 必选 | 是否获取获取所有交易 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |


**返回值 或 回调**

`
Web3ResponseCompletion<EthereumBlockObject?>
`
EthereumBlockObject为对应结果

**示例**

```
 web3.eth.getBlockByNumber(block: .latest, fullTransactionObjects: true) {  (result) in
     switch result.status{
     case .success(_):
         do{}
     case .failure(_):
         do{}
     }
 }

```

#### getUncleByBlockHashAndIndex

>通过区块哈希和索引获取uncle区块

**接口声明**

```
public func getUncleByBlockHashAndIndex(
    blockHash: EthereumData,
    uncleIndex: EthereumQuantity,
    response: @escaping Web3ResponseCompletion<EthereumBlockObject?>
)
```



**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumAddress      | 必选 | 区块哈希 |
| uncleIndex | Int      | 必选 | 存储索引地址 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |


**返回值 或 回调**

`
Web3ResponseCompletion<EthereumBlockObject?>
`
EthereumBlockObject为对应结果

**示例**

```
let uncleIndex = EthereumQuantity(quantity: BigUInt("1")!)
web3.eth.getUncleByBlockNumberAndIndex(block: .latest, uncleIndex: uncleIndex) { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```

#### getUncleCountByBlockNumber

>获取对应区块类型的叔区块数量

```
public func getUncleCountByBlockNumber(
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumQuantity>
)

```

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity即为对应区块数量

**示例**

```
web3.eth.getUncleCountByBlockNumber(block: .latest) { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```


#### getBlockTransactionCountByHash

>根据hash获取对应区块的交易数量

```
public func getBlockTransactionCountByHash(
    blockHash: EthereumData,
    response: @escaping Web3ResponseCompletion<EthereumQuantity>
)

```


**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumData      | 必选 | 交易哈希 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |

**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity即为对应数量

**示例**

```
 let blockHash = EthereumData(bytes: Data(hex: "0x..."))
 web3.eth.getBlockTransactionCountByHash(blockHash: blockHash) { (result) in
     switch result.status{
     case .success(_):
         do{}
     case .failure(_):
         do{}
     }
 }

```


#### getBlockTransactionCountByNumber

>根据区块类型获取对应区块的交易数量

```
public func getBlockTransactionCountByNumber(
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumQuantity>
)

```



**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumData      | 必选 | 交易哈希 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |


**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity即为对应数量

EthereumData属性中的bytes即为对应存储数据

**示例**

```
 web3.eth.getBlockTransactionCountByNumber(block: .latest) { (result) in
     switch result.status{
     case .success(_):
         do{}
     case .failure(_):
         do{}
     }
 }
 
```


#### getTransactionByHash


>根据哈希获取交易对象

**接口声明**

```
public func getTransactionByHash(
    blockHash: EthereumData,
    response: @escaping Web3ResponseCompletion<EthereumTransactionObject?>
) 

```


**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumData      | 必选 | 交易哈希 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumTransactionObject?>
`
EthereumTransactionObject即为交易对象

**示例**

```
let transactionHash = EthereumData(bytes: Data(hex: "0x..").bytes)
web3.eth.getTransactionByHash(blockHash: transactionHash) { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```

#### getTransactionFromBlock

>根据区块哈希获取指定下标区块上的交易对象

**接口声明**


```
public func getTransactionByBlockHashAndIndex(
    blockHash: EthereumData,
    transactionIndex: EthereumQuantity,
    response: @escaping Web3ResponseCompletion<EthereumTransactionObject?>
) 

```

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| blockHash | EthereumAddress      | 必选 | 区块哈希 |
| transactionIndex | Int      | 必选 | 区块下标 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |


**返回值 或 回调**

`
Web3ResponseCompletion<EthereumTransactionObject?>
`
EthereumTransactionObject即为交易对象

**示例**

```
let blockHash = EthereumData(bytes: Data(hex: "0x..").bytes)
let transactionIndex = EthereumQuantity(integerLiteral: 1)
web3.eth.getTransactionByBlockHashAndIndex(blockHash: blockHash, transactionIndex: transactionIndex) 	{ (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
        
```


#### getTransactionReceipt

>根据交易哈希获取交易回执

**接口声明**

```
public func getTransactionReceipt(
    transactionHash: EthereumData,
    response: @escaping Web3ResponseCompletion<EthereumTransactionReceiptObject?>
)

```

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| transactionHash | EthereumData      | 必选 | 交易哈希 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumTransactionReceiptObject?>
`
EthereumTransactionReceiptObject即为交易回执对象

**示例**

```
let transactionHash = EthereumData(bytes: Data(hex: "0x..").bytes)
web3.eth.getTransactionReceipt(transactionHash: transactionHash) { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```


#### getTransactionCount

>获取nonce（某一地址上的交易数量）

**接口声明**

```
public func getTransactionCount(
    address: EthereumAddress,
    block: EthereumQuantityTag,
    response: @escaping Web3ResponseCompletion<EthereumQuantity>
    )
```    


**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity即为nonce

**示例**

```
 let address = EthereumAddress(hexString: "0x..")
 web3.eth.getTransactionCount(address: address, block: .latest) { (result) in
     switch result.status{
     case .success(_):
         do{}
     case .failure(_):
         do{}
     }
 }

```


#### estimateGas


>获取对应交易预估手续费

**接口声明**


```
public func estimateGas(call: EthereumCall, response: @escaping Web3ResponseCompletion<EthereumQuantity>)
```

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| position | Int      | 必选 | 存储索引地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity为对应手续费gas数量

**示例**

```
let callData = EthereumData(bytes: Data(hex: "0x..").bytes)
let contractAddress = EthereumAddress(hexString: "0x..")
let thecall = EthereumCall(from: nil, to: contractAddress!, gas: nil, gasPrice: nil, value: nil, data: 	callData)
web3.eth.estimateGas(call: thecall) { (gasestResp) in
    switch gasestResp.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```



#### mining

>获取节点是否在挖矿

**接口声明**

```
public func mining(response: @escaping Web3ResponseCompletion<Bool>)
```

**参数**

无

**返回值 或 回调**

`
Web3ResponseCompletion<Bool>
`
Bool对应挖矿状态

**示例**

```
web3.eth.mining { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```

#### hashrate

>获取节点挖矿每秒中hash的数量

**接口声明**

```
public func hashrate(response: @escaping Web3ResponseCompletion<EthereumQuantity>)
```

**参数**

无

**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity为hash的数量

**示例**

```
web3.eth.hashrate { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```


#### syncing

>获取节点的同步状态

**接口声明**

```
public func syncing(response: @escaping Web3ResponseCompletion<EthereumSyncStatusObject>)
```

**参数**

| 名称  | 类型  | 属性  | 含义 |
| :---------------:| :---------------: |:---------------:| :---------------:|
| address | EthereumAddress      | 必选 | 账户地址 |
| position | Int      | 必选 | 存储索引地址 |
| block | EthereumQuantityTag      | 必选 | 区块高度类型 |
| response | Web3ResponseCompletion<T>      | 必选 | 回调 |



**返回值 或 回调**

`
EthereumSyncStatusObject
`

其对应属性有

syncing: Bool //是否在同步,如果为true，其他值为nil
startingBlock: EthereumQuantity? //如果syncing为false，则其含义为开始同步的区块
currentBlock: EthereumQuantity? //如果syncing为false，则其含义为当前块高，同eth_blockNumber
highestBlock: EthereumQuantity? //如果syncing为false，则其含义为预计的最高块高

**示例**

```
web3.eth.syncing{ (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```


#### gasPrice

>获取最新快的交易单价

**接口声明**

```
public func gasPrice(response: @escaping Web3ResponseCompletion<EthereumQuantity>)
```

**参数**
无

**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity为对应的交易单价

**示例**

```
web3.eth.gasPrice { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```


#### accounts


>获取节点对应的账户

**接口声明**

```
public func accounts(response: @escaping Web3ResponseCompletion<[EthereumAddress]>)
```


**参数**

无

**返回值 或 回调**

`
Web3ResponseCompletion<[EthereumAddress]>
`
[EthereumAddress]为账户列表

**示例**

```
web3.eth.accounts { (result) in
     switch result.status{
     case .success(_):
         do{}
     case .failure(_):
         do{}
     }
 }

```

#### blockNumber

>获取节点当前交易区块数量

**接口声明**

```
public func blockNumber(response: @escaping Web3ResponseCompletion<EthereumQuantity>)
```


**参数**

无

**返回值 或 回调**

`
Web3ResponseCompletion<EthereumQuantity>
`
EthereumQuantity为对应区块数量

**示例**

```
web3.eth.blockNumber { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}

```

#### protocolVersion

>获取协议版本号

**接口声明**

```
public func protocolVersion(response: @escaping Web3ResponseCompletion<String>)
```


**参数**

无

**返回值 或 回调**

`
Web3ResponseCompletion<String>
`
String为协议版本号

**示例**

```
web3.eth.protocolVersion { (result) in
    switch result.status{
    case .success(_):
        do{}
    case .failure(_):
        do{}
    }
}
```


#### call
同：[合约call调用](#合约call调用)


#### sendRawTransaction
同：[合约sendrawtransaction调用](#合约sendrawtransaction调用)