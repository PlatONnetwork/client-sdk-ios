
//  Created by matrixelement on 9/11/2018.
//  Copyright © 2018 ju. All rights reserved.
//

import Foundation
import BigInt
import Localize_Swift

let PlatonTxTypeDeploy = Data(bytes: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01])
let PlatonTxTypeFunc = Data(bytes: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02])

let web3RPCWaitTimeout = 60.0

public extension Web3.Eth{
    
    func platonDeployContract(abi : String,
                              bin : Data,
                              sender : String,
                              privateKey : String,
                              gasPrice : BigUInt,
                              gas : BigUInt,
                              estimateGas : Bool,
                              timeout: dispatch_time_t,
                              completion : ContractDeployCompletion?
        ){
        
        var completion = completion
        let txTypePart = RLPItem(bytes: PlatonTxTypeDeploy.bytes)
        let binPart = RLPItem(bytes: (bin.bytes))
        let abiPart = RLPItem(bytes: (abi.data(using: .utf8)?.bytes)!)
        
        let rlp = RLPItem.array(txTypePart,binPart,abiPart)
        let rawRlp = try? RLPEncoder().encode(rlp)

        let semaphore = DispatchSemaphore(value: 0)
        
        let deployQueue = DispatchQueue(label: "platonDeployContractIdentifer")
        
        var estimatedGas : EthereumQuantity?
        
        if estimateGas{
            deployQueue.async {
                let from = EthereumAddress(hexString: sender)
                print("platonDeployContract estimatedGas begin 💪 semaphone\(semaphore)")
                let call = EthereumCall(from: from, to: nil, gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: rawRlp!))
                self.estimateGas(call: call) { (gasestResp) in
                    switch gasestResp.status{
                    case .success(_):
                        do {
                            estimatedGas = gasestResp.result
                            print("platonDeployContract estimatedGas done😀")
                            semaphore.signal()
                        }
                    case .failure(_):
                        print("platonDeployContract estimatedGas fail😭")
                        self.deploy_fail(code: gasestResp.getErrorCode(), errorMsg: gasestResp.getErrorLocalizedDescription(), completion: &completion)
                        semaphore.signal()
                    }
                }
            }
        }else{
            estimatedGas = EthereumQuantity(quantity: gas)
            semaphore.signal()
        }
        

        
        var nonce : EthereumQuantity?
        deployQueue.async {
            if semaphore.wait(timeout: .now() + web3RPCWaitTimeout) == .timedOut{
                self.deploy_timeout(completion: &completion)
                return
            }
            
            if estimatedGas == nil{
                self.deploy_fail(code: -1, errorMsg: "gas is empty", completion: &completion)
                semaphore.signal()
                return
            }
            
            let address = try! EthereumAddress(hex: sender, eip55: false)
            self.getTransactionCount(address: address, block: .latest, response: {
                nonceResp in
                
                switch nonceResp.status{
                case .success(_):
                    nonce = nonceResp.result
                    print("platonDeployContract get nonce done😀" + "nonce:" + String((nonceResp.result?.quantity)!))
                    semaphore.signal()
                case .failure(_):
                    self.deploy_fail(code: nonceResp.getErrorCode(), errorMsg: nonceResp.getErrorLocalizedDescription(), completion: &completion)
                    print("platonDeployContract get nonce fail😭")
                    semaphore.signal()
                    
                }
                
            })
            
        }

        var txHash = EthereumData(bytes: [])
        deployQueue.async {
            
            if semaphore.wait(timeout: .now() + web3RPCWaitTimeout) == .timedOut{
                self.deploy_timeout(completion: &completion)
            }
            
            if nonce == nil{
                semaphore.signal()
                return
            }
            
            let data = EthereumData(bytes: rawRlp!)
            var fgas : EthereumQuantity?
            if estimateGas{
                fgas = estimatedGas
            }else{
                fgas = EthereumQuantity(quantity: gas)
            }
            let tx = EthereumTransaction(nonce: nonce, gasPrice: EthereumQuantity(quantity: gasPrice), gas: fgas, from: nil, to: nil, value: EthereumQuantity(quantity: BigUInt("0")!), data: data)
            let chainID = EthereumQuantity(quantity: BigUInt(DefaultChainId)!)
            let signedTx = try? tx.sign(with: try! EthereumPrivateKey(hexPrivateKey: privateKey), chainId: chainID) as EthereumSignedTransaction
            
            self.sendRawTransaction(transaction: signedTx!, response: { (sendTxResp) in
                switch sendTxResp.status{
                case .success(_):
                    txHash = sendTxResp.result!
                    print("platonDeployContract Deploy done😀")
                    semaphore.signal()
                case .failure(_):
                    self.deploy_fail(code: sendTxResp.getErrorCode(), errorMsg: sendTxResp.getErrorLocalizedDescription(), completion: &completion)
                    print("platonDeployContract Deploy fail😭")
                    semaphore.signal()
                    return
                }
            })
        }
        
        deployQueue.async {
            
            if semaphore.wait(timeout: .now() + web3RPCWaitTimeout) == .timedOut{
                self.deploy_timeout(completion: &completion)
            }
            
            if txHash.bytes.count == 0{
                semaphore.signal()
                return
            }
            
            self.platongetTransactionReceipt(txHash: txHash.hex(), loopTime: 10, completion: { (ret, data) in
                switch ret{
                case .success:
                    guard let receptionresp = data as? EthereumTransactionReceiptObject else{
                        self.deploy_empty(completion: &completion)
                        return
                    }
                    completion?(PlatonCommonResult.success,receptionresp.contractAddress?.hex(), txHash.hex())
                    self.deploy_success(receptionresp.contractAddress?.hex(), txHash.hex(), completion: &completion)
                    
                    print("platonDeployContract Receipt done😀")
                    semaphore.signal()
                case .fail(let code, let errMsg):
                    self.deploy_fail(code: code!, errorMsg: errMsg!, completion: &completion)
                    print("platonDeployContract Receipt fail😭")
                    semaphore.signal()
                    return
                }
            })
        }
    }
    
    
    func parserEvent(){
        
        self.getTransactionReceipt(transactionHash: EthereumData(bytes: [0x00]), response: { receptionresp in
            switch receptionresp.status{
            case .success(_):
                do {
                    /*
                     let firstTopicBytes = receptionresp.result??.logs[0].topics[0].bytes
                     let logdata = receptionresp.result??.logs[0].data
                     let decoderesult = try? RLPDecoder().decode((logdata?.bytes)!)
                     let value = decoderesult?.array![0].bytes
                     let result = String(bytes: (decoderesult?.array![1].bytes)!)
                     */
                }
            case .failure(_):
                do {
                    
                }
            }
            
        })
    }
    
    func platonCall(contractAddress : String ,data: Data, from: String?,gas: EthereumQuantity?, gasPrice: EthereumQuantity?, value: EthereumQuantity?,outputs: [SolidityParameter],completion : ContractCallCompletion?) {
        
        var completion = completion

        var fromE : EthereumAddress?
        if from != nil{
            fromE = try? EthereumAddress(hex: from!, eip55: false)
        }
        let callParam = EthereumCall(from: fromE, to: EthereumAddress(hexString: contractAddress)!, gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: data.bytes))
        
        call(call: callParam, block: .latest) { (resp) in
            switch resp.status{
            case .success(_):
                let data = Data(bytes: (resp.result?.bytes)!)
                let dictionary = try? ABI.decodeParameters(outputs, from: data.toHexString())
                //NSLog("\(functionName) call result:\n\(dictionary)")
                if dictionary != nil && (dictionary?.count)! > 0{
                    self.call_success(dictionary: dictionary as AnyObject, completion: &completion)
                }else{
                    self.call_success(dictionary: data as AnyObject, completion: &completion)
                }
            case .failure(_):
                self.call_fail(code: resp.getErrorCode(), errorMsg: resp.getErrorLocalizedDescription(), completion: &completion)
            }
        }
    }
    
    func platonCall(contractAddress : String,functionName : String, from: String?, params : [Data], outputs: [SolidityParameter],completion : ContractCallCompletion?) {
        
        var completion = completion
        let txTypePart = RLPItem(bytes: PlatonTxTypeFunc.bytes)
        let funcItemPart = RLPItem(bytes: (functionName.data(using: .utf8)?.bytes)!)
        var items : [RLPItem] = []
        items.append(txTypePart)
        items.append(funcItemPart)
        for data in params{
            items.append(RLPItem(bytes: data.bytes))
        }
        
        let rlp = RLPItem.array(items)
        let rawRlp = try? RLPEncoder().encode(rlp)
        var fromE : EthereumAddress?
        if from != nil{
            fromE = try? EthereumAddress(hex: from!, eip55: false)
        }
        let callParam = EthereumCall(from: fromE, to: EthereumAddress(hexString: contractAddress)!, gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: rawRlp!))
    
        call(call: callParam, block: .latest) { (resp) in
            switch resp.status{
            case .success(_):
                let data = Data(bytes: (resp.result?.bytes)!)
                let dictionary = try? ABI.decodeParameters(outputs, from: data.toHexString())
                //NSLog("\(functionName) call result:\n\(dictionary)")
                if dictionary != nil && (dictionary?.count)! > 0{
                    self.call_success(dictionary: dictionary as AnyObject, completion: &completion)
                }else{
                    self.call_success(dictionary: data as AnyObject, completion: &completion)
                }
                self.call_success(dictionary: dictionary as AnyObject, completion: &completion)
            case .failure(_):
                self.call_fail(code: resp.getErrorCode(), errorMsg: resp.getErrorLocalizedDescription(), completion: &completion)
            }
        }
    }
    
    
    func plantonSendRawTransaction(contractAddress : String,data: Bytes, sender: String, privateKey: String, gasPrice : BigUInt, gas : BigUInt, value: EthereumQuantity?, estimated: Bool ,completion: ContractSendRawCompletion?){
        
        var completion = completion
        
        let semaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue(label: "plantonSendRawTransactionQueue")
        
        var nonce : EthereumQuantity?
        queue.async {
            let address = try! EthereumAddress(hex: sender, eip55: false)
            self.getTransactionCount(address: address, block: .latest, response: {
                nonceResp in
                
                switch nonceResp.status{
                case .success(_):
                    nonce = nonceResp.result
                    semaphore.signal()
                case .failure(_):
                    self.sendRawTransaction_fail(code: nonceResp.getErrorCode(), errorMsg: nonceResp.getErrorLocalizedDescription(), completion: &completion)
                    semaphore.signal()
                    return
                    
                }
            })
        }
        
        var estimatedGas : EthereumQuantity?
        if estimated{
            queue.async {
                if semaphore.wait(timeout: .now() + web3RPCWaitTimeout) == .timedOut{
                    self.sendRawTransaction_timeout(completion: &completion)
                    return
                }
                
                if nonce == nil{
                    return
                }
                
                let toContract = EthereumAddress(hexString: contractAddress)
                let call = EthereumCall(from: nil, to: toContract!, gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: data))
                self.estimateGas(call: call) { (gasestResp) in
                    
                    switch gasestResp.status{
                    case .success(_):
                        
                        estimatedGas = gasestResp.result
                        semaphore.signal()
                        
                    case .failure(_):
                        DispatchQueue.main.async {
                            completion?(PlatonCommonResult.fail(gasestResp.getErrorCode(), gasestResp.getErrorLocalizedDescription()),nil)
                            completion = nil
                        }
                        semaphore.signal()
                        return
                    }
                }
            }
        }else{
            estimatedGas = EthereumQuantity(quantity: gas)
        }
        
        queue.async {
            if semaphore.wait(wallTimeout: .now() + web3RPCWaitTimeout) == .timedOut{
                self.sendRawTransaction_timeout(completion: &completion)
                return
            }
            
            if nonce == nil{
                return
            }
            
            let data = EthereumData(bytes: data)
            let ethConAddr = try? EthereumAddress(hex: contractAddress, eip55: false)
            let egasPrice = EthereumQuantity(quantity: gasPrice)
            
            let from = try? EthereumAddress(hex: sender, eip55: false)
            
            var sendValue = EthereumQuantity(quantity: BigUInt("0")!)
            if value != nil{
                sendValue = value!
            }
            let tx = EthereumTransaction(nonce: nonce, gasPrice: egasPrice, gas: estimatedGas, from: from, to: ethConAddr, value: sendValue, data: data)
            let signedTx = try? tx.sign(with: try! EthereumPrivateKey(hexPrivateKey: privateKey), chainId: 0) as EthereumSignedTransaction
            
            var txHash = EthereumData(bytes: [])
            self.sendRawTransaction(transaction: signedTx!, response: { (sendTxResp) in
                
                switch sendTxResp.status{
                case .success(_):
                    txHash = sendTxResp.result!
                    semaphore.signal()
                    self.sendRawTransaction_success(data: Data(bytes: txHash.bytes), completion: &completion)
                case .failure(_):
                    self.sendRawTransaction_fail(code: sendTxResp.getErrorCode(), errorMsg: sendTxResp.getErrorLocalizedDescription(), completion: &completion)
                    semaphore.signal()
                    return
                }
            })
        }
        
    }

    func plantonSendRawTransaction(contractAddress : String,
                                   functionName : String,
                                   _ params : [Data],
                                   sender: String,
                                   privateKey: String,
                                   gasPrice : BigUInt,
                                   gas : BigUInt,
                                   value: EthereumQuantity?,
                                   estimated: Bool,
                                   completion: ContractSendRawCompletion?){
        
        let txTypePart = RLPItem(bytes: PlatonTxTypeFunc.bytes)
        let funcItemPart = RLPItem(bytes: (functionName.data(using: .utf8)?.bytes)!)
        var items : [RLPItem] = []
        items.append(txTypePart)
        items.append(funcItemPart)
        for data in params{
            items.append(RLPItem(bytes: data.bytes))
        }
        
        let rlp = RLPItem.array(items)
        let rawRlp = try? RLPEncoder().encode(rlp)
        
        self.plantonSendRawTransaction(contractAddress: contractAddress, data: rawRlp!, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas,value: value, estimated: estimated, completion: completion)
        
    }
    
    public typealias Web3ResponseCompletion<Result: Codable> = (_ resp: Web3Response<Result>) -> Void
    
    public func platonEstimateGas(mutiply: Float, call: EthereumCall, response: @escaping Web3ResponseCompletion<EthereumQuantity>){
        self.estimateGas(call: call, response: response)
    }
    
    
    func platongetTransactionReceipt(txHash: String, loopTime: Int, completion: PlatonCommonCompletion?) {
        
        var completion = completion
        
        let semaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue(label: "platongetTransactionReceipt")
        var time = loopTime
        queue.async {
            repeat{
                NSLog("begin getTransactionReceipt 💪:\(txHash)")
                self.getTransactionReceipt(transactionHash: EthereumData(bytes: Data(hex: txHash).bytes)) { (response) in
                    time = time - 1
                    switch response.status{
                    case .success(_):
                        
                        DispatchQueue.main.async {
                            NSLog("success getTransactionReceipt 🙂")
                            completion?(.success,response.result as AnyObject)
                            completion = nil
                        }
                        semaphore.signal()
                        time = 0
                    case .failure(_):
                        NSLog("fail getTransactionReceipt 😭")
                        if time == 0{
                            DispatchQueue.main.async {
                                completion?(PlatonCommonResult.fail(response.getErrorCode(), response.getErrorLocalizedDescription()),nil)
                                completion = nil
                            }
                            semaphore.signal()
                            time = 0
                        }
                        semaphore.signal()
                    }
                }
                sleep(UInt32(3.0))
                semaphore.wait(timeout: .now() + 3)
            }while time > 0
        }
       
        

    }
    
    
       
}
