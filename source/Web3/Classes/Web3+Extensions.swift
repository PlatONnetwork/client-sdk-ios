
//  Created by matrixelement on 9/11/2018.
//  Copyright © 2018 ju. All rights reserved.
//

import Foundation
import BigInt
import Localize_Swift


let web3RPCWaitTimeout = 60.0

public extension Web3.Platon {
    
    func platonCall<T: Decodable>(
        contractAddress: String,
        from: String,
        inputs: Data,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<T>?>?) {
        var completion = completion
        let fromEthereumAddress = try? EthereumAddress(hex: from, eip55: false)
        
        let ethereumCall = EthereumCall(from: fromEthereumAddress, to: EthereumAddress(hexString: contractAddress), gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: inputs.bytes))
        call(call: ethereumCall, block: .latest) { (response) in
            switch response.status {
            case .success(_):
                
                guard let bytes = response.result?.bytes else {
                    DispatchQueue.main.async {
                        completion?(.fail(-1, Localized("RPC_Response_empty")), nil)
                        completion = nil
                    }
                    return
                }
                
                guard let model = try? JSONDecoder().decode(PlatonContractCallResponse<T>.self, from: Data(bytes: bytes)) else {
                    DispatchQueue.main.async {
                        completion?(.fail(-1, "decode failed"), nil)
                        completion = nil
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(.success, model)
                    completion = nil
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion?(.fail(response.getErrorCode(), response.getErrorLocalizedDescription()), nil)
                    completion = nil
                }
            }
        }
    }
    
//    func platonCall(contractAddress: String,
//                    from: String,
//                    inputs: Data,
//                    completion:ContractCallCompletion?) {
//        var completion = completion
//        let fromEthereumAddress = try? EthereumAddress(hex: from, eip55: false)
//
//        let ethereumCall = EthereumCall(from: fromEthereumAddress, to: EthereumAddress(hexString: contractAddress), gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: inputs.bytes))
//
//        call(call: ethereumCall, block: .latest) { (response) in
//            switch response.status {
//            case .success(_):
//                guard let bytes = response.result?.bytes, bytes.count > 0 else {
//                    self.call_empty(completion: &completion)
//                    return
//                }
//
//                guard let reponseData = String(bytes: bytes).data(using: .utf8) else {
//                    self.call_fail(code: -1, errorMsg: "reponse not transfer to string", completion: &completion)
//                    return
//                }
//
//                let jsonObject = try? JSONSerialization.jsonObject(with: reponseData, options: .allowFragments)
//                guard let json = jsonObject else {
//                    self.call_fail(code: -1, errorMsg: "not serialization json string", completion: &completion)
//                    return
//                }
//
//                self.call_success(dictionary: jsonObject as AnyObject?, completion: &completion)
//
//            case .failure(_):
//                self.call_fail(code: response.getErrorCode(), errorMsg: response.getErrorLocalizedDescription(), completion: &completion)
//            }
//        }
//    }
    
    func platonSendRawTransaction(contractAddress: String,
                                  data: Bytes,
                                  sender: String,
                                  privateKey: String,
                                  gasPrice: BigUInt,
                                  gas: BigUInt?,
                                  value: EthereumQuantity?,
                                  estimated: Bool,
                                  completion: PlatonCommonCompletionV2<Data?>?){
        var completion = completion
        let semaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue(label: "platonSendRawTransactionQueue")
        
        var nonce : EthereumQuantity?
        queue.async {
            let address = try! EthereumAddress(hex: sender, eip55: false)
            self.getTransactionCount(address: address, block: .latest, response: {
                nonceResp in
                
                switch nonceResp.status{
                case .success(_):
                    nonce = nonceResp.result
                    Debugger.debugPrint("nonce:\(String((nonceResp.result?.quantity)!))")
                    semaphore.signal()
                case .failure(_):
                    DispatchQueue.main.async {
                        completion?(.fail(nonceResp.getErrorCode(), nonceResp.getErrorLocalizedDescription()), nil)
                        completion = nil
                    }
                    semaphore.signal()
                    return
                    
                }
            })
        }
        
        var estimatedGas : EthereumQuantity?
        estimatedGas = EthereumQuantity(quantity: gas ?? 0)
//        if estimated{
//            queue.async {
//                if semaphore.wait(timeout: .now() + web3RPCWaitTimeout) == .timedOut{
//                    self.sendRawTransaction_timeout(completion: &completion)
//                    return
//                }
//                
//                if nonce == nil{
//                    return
//                }
//                
//                let toContract = EthereumAddress(hexString: contractAddress)
//                let call = EthereumCall(from: nil, to: toContract!, gas: nil, gasPrice: nil, value: nil, data: EthereumData(bytes: data))
//                self.estimateGas(call: call) { (gasestResp) in
//                    
//                    switch gasestResp.status{
//                    case .success(_):
//                        
//                        estimatedGas = gasestResp.result
//                        semaphore.signal()
//                        
//                    case .failure(_):
//                        self.sendRawTransaction_fail(code: gasestResp.getErrorCode(), errorMsg: gasestResp.getErrorLocalizedDescription(), completion: &completion)
//                        semaphore.signal()
//                        return
//                    }
//                }
//            }
//        }else{
//            estimatedGas = EthereumQuantity(quantity: gas ?? 0)
//        }
        
        queue.async {
            if semaphore.wait(wallTimeout: .now() + web3RPCWaitTimeout) == .timedOut{
                DispatchQueue.main.async {
                    completion?(.fail(-1, Localized("Request_timeout")), nil)
                    completion = nil
                }
                return
            }
            
            if nonce == nil{
                return
            }
            
            let data = EthereumData(bytes: data)
            let ethConAddr = try? EthereumAddress(hex: contractAddress, eip55: true)
            let egasPrice = EthereumQuantity(quantity: gasPrice)
            
            let from = try? EthereumAddress(hex: sender, eip55: true)
            
            var sendValue = EthereumQuantity(quantity: BigUInt("0")!)
            if value != nil{
                sendValue = value!
            }
            let tx = EthereumTransaction(nonce: nonce, gasPrice: egasPrice, gas: estimatedGas, from: from, to: ethConAddr, value: sendValue, data: data)
            let chainID = EthereumQuantity(quantity: BigUInt(PlatonConfig.PlatonChainId.defaultChainId)!)
            let checkedPrivateKey = privateKey.privateKeyAdd0xPrefix()
            
            let signedTx = try? tx.sign(with: try! EthereumPrivateKey(hexPrivateKey: checkedPrivateKey), chainId: chainID) as EthereumSignedTransaction
            
            var txHash = EthereumData(bytes: [])
            self.sendRawTransaction(transaction: signedTx!, response: { (sendTxResp) in
                
                switch sendTxResp.status{
                case .success(_):
                    txHash = sendTxResp.result!
                    semaphore.signal()
                    DispatchQueue.main.async {
                        completion?(.success, Data(bytes: txHash.bytes))
                        completion = nil
                    }
                case .failure(_):
                    semaphore.signal()
                    DispatchQueue.main.async {
                        completion?(.fail(sendTxResp.getErrorCode(), sendTxResp.getErrorLocalizedDescription()), nil)
                        completion = nil
                    }
                    return
                }
            })
        }
        
    }
    
    typealias Web3ResponseCompletion<Result: Codable> = (_ resp: Web3Response<Result>) -> Void
    
    func platonEstimateGas(mutiply: Float, call: EthereumCall, response: @escaping Web3ResponseCompletion<EthereumQuantity>){
        self.estimateGas(call: call, response: response)
    }
    
    
    func platonGetTransactionReceipt(txHash: String, loopTime: Int, completion: PlatonCommonCompletion?) {
        
        var completion = completion
        
        let semaphore = DispatchSemaphore(value: 0)
        let queue = DispatchQueue(label: "platonGetTransactionReceipt")
        var time = loopTime
        queue.async {
            repeat{
                Debugger.debugPrint("begin getTransactionReceipt 💪:\(txHash)")
                self.getTransactionReceipt(transactionHash: EthereumData(bytes: Data(hex: txHash).bytes)) { (response) in
                    time = time - 1
                    switch response.status{
                    case .success(_):
                        
                        DispatchQueue.main.async {
                            Debugger.debugPrint("success getTransactionReceipt 🙂")
                            completion?(.success,response.result as AnyObject)
                            completion = nil
                        }
                        semaphore.signal()
                        time = 0
                    case .failure(_):
                        Debugger.debugPrint("fail getTransactionReceipt 😭")
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
                
                if semaphore.wait(timeout: .now() + 3) == .timedOut{
                    
                }else{
                    //sleep for one second
                    sleep(1)
                }
            }while time > 0
        }
    }
}

public extension EthereumTransactionReceiptObject{
    
    func decodeEvent(event: SolidityEvent){
        
    }
}
