
//  Created by matrixelement on 9/11/2018.
//  Copyright © 2018 ju. All rights reserved.
//

import Foundation
import BigInt


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
                        completion?(.fail(-1, "RPC_Response_empty"), nil)
                        completion = nil
                    }
                    return
                }

                guard let response = try? JSONDecoder().decode(PlatonContractCallResponse<T>.self, from: Data(bytes: bytes)) else {
                    DispatchQueue.main.async {
                        completion?(.fail(-1, "decode failed"), nil)
                        completion = nil
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion?(.success, response)
                    completion = nil
                }
            case .failure(_):
                DispatchQueue.main.async {
                    completion?(.fail(response.error?.code, response.error?.message), nil)
                    completion = nil
                }
            }
        }
    }
    
    func platonGetNonce(
        sender: String,
        completion: PlatonCommonCompletionV2<EthereumQuantity?>?) {
        
        let queue = DispatchQueue(label: "platonGetNonceQueue")
        let semaphore = DispatchSemaphore(value: 1)
        
        semaphore.wait()
        var nonce : EthereumQuantity?
        queue.async {
            let address = try! EthereumAddress(hex: sender, eip55: false)
            self.getTransactionCount(address: address, block: .pending, response: {
                nonceResp in
                
                switch nonceResp.status{
                case .success(_):
                    nonce = nonceResp.result
                    Debugger.debugPrint("nonce:\(String((nonceResp.result?.quantity)!))")
                    semaphore.signal()
                case .failure(_):
                    semaphore.signal()
                }
            })
        }
        
        if (nonce?.quantity ?? BigUInt.zero) <= BigUInt.zero {
            semaphore.wait()
            queue.async {
                let address = try! EthereumAddress(hex: sender, eip55: false)
                self.getTransactionCount(address: address, block: .latest, response: { (nonceResp) in
                    switch nonceResp.status{
                    case .success(_):
                        nonce = nonceResp.result
                        Debugger.debugPrint("nonce:\(String((nonceResp.result?.quantity)!))")
                        semaphore.signal()
                    case .failure(_):
                        semaphore.signal()
                    }
                })
            }
        }
        
        semaphore.wait()
        guard nonce != nil else {
            completion?(.fail(Web3Error.requestTimeout(nil).code, Web3Error.requestTimeout(nil).message), nil)
            semaphore.signal()
            return
        }
        
        completion?(.success, nonce)
        semaphore.signal()
    }
    
    func platonSignTransaction(to: String,
                               nonce: EthereumQuantity,
                               data: Bytes,
                               sender: String,
                               privateKey: String,
                               gasPrice: BigUInt?,
                               gas: BigUInt?,
                               value: EthereumQuantity?,
                               estimated: Bool) -> EthereumSignedTransaction? {
        
        var estimatedGas : EthereumQuantity?
        estimatedGas = EthereumQuantity(quantity: gas ?? 0)
        
        let data = EthereumData(bytes: data)
        let ethConAddr = try? EthereumAddress(hex: to, eip55: false)
        let egasPrice = EthereumQuantity(quantity: gasPrice ?? PlatonConfig.FuncGasPrice.defaultGasPrice)
        
        let from = try? EthereumAddress(hex: sender, eip55: false)
        
        var sendValue = EthereumQuantity(quantity: BigUInt("0"))
        if value != nil{
            sendValue = value!
        }
        let tx = EthereumTransaction(nonce: nonce, gasPrice: egasPrice, gas: estimatedGas, from: from, to: ethConAddr, value: sendValue, data: data)
        let chainID = EthereumQuantity(quantity: BigUInt(self.properties.chainId)!)
        let checkedPrivateKey = privateKey.privateKeyAdd0xPrefix()
        
        let signedTx = try? tx.sign(with: try! EthereumPrivateKey(hexPrivateKey: checkedPrivateKey), chainId: chainID) as EthereumSignedTransaction
        return signedTx
    }
    
    func platonSendRawTransaction(contractAddress: String,
                                  data: Bytes,
                                  sender: String,
                                  privateKey: String,
                                  gasPrice: BigUInt?,
                                  gas: BigUInt?,
                                  value: EthereumQuantity?,
                                  estimated: Bool,
                                  completion: PlatonCommonCompletionV2<Data?>?){

        let semaphore = DispatchSemaphore(value: 1)

        var tempNonce: EthereumQuantity?
        semaphore.wait()
        platonGetNonce(sender: sender) { (result, nonce) in
            switch result {
            case .success:
                tempNonce = nonce
                semaphore.signal()
            case .fail(let code, let message):
                completion?(.fail(code, message), nil)
                semaphore.signal()
                return
            }
        }
        
        semaphore.wait()
        guard let nonce = tempNonce else {
            completion?(.fail(Web3Error.emptyNonce.code, Web3Error.emptyNonce.message), nil)
            semaphore.signal()
            return
        }
        
        let tempSignedTx = platonSignTransaction(to: contractAddress, nonce: nonce, data: data, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: value, estimated: estimated)
        guard let signedTx = tempSignedTx else {
            completion?(.fail(Web3Error.signedTxError.code, Web3Error.signedTxError.message), nil)
            semaphore.signal()
            return
        }

        var txHash = EthereumData(bytes: [])
        sendRawTransaction(transaction: signedTx) { (sendTxResp) in
            switch sendTxResp.status {
            case .success(_):
                completion?(.success, Data(bytes: signedTx.hash?.hexToBytes() ?? Bytes()))
                semaphore.signal()
            case .failure(let err):
                switch err {
                case .reponseTimeout:
                    completion?(.success, Data(bytes: signedTx.hash?.hexToBytes() ?? Bytes()))
                case .requestTimeout:
                    completion?(.fail(err.code, "RPC_Response_connectionTimeout"), nil)
                default:
                    completion?(.fail(err.code, err.message), nil)
                }
                semaphore.signal()
            }
        }
    }
    
    typealias Web3ResponseCompletion<Result: Codable> = (_ resp: Web3Response<Result>) -> Void
    
    func platonEstimateGas(mutiply: Float, call: EthereumCall, response: @escaping Web3ResponseCompletion<EthereumQuantity>){
        self.estimateGas(call: call, response: response)
    }
    
    func getTransactionReceipt(
        txHash: String,
        loopTime: Int,
        completion: PlatonCommonCompletionV2<EthereumTransactionReceiptObject?>?) {
        var completion = completion

        let sema = DispatchSemaphore(value: 1)
        let queue = DispatchQueue(label: "platonGetTransactionReceipt")
        var time = loopTime

        queue.async {
            repeat {
                sema.wait()
                self.getTransactionReceipt(transactionHash: EthereumData(bytes: Data(hex: txHash).bytes)) { (response) in
                    time = time - 1
                    switch response.status {
                    case .success(let resp):
                        guard
                            let receipt = resp,
                            receipt.logs.count > 0,
                            receipt.logs[0].data.hex().count > 0 else {
                                completion?(PlatonCommonResult.fail(-1, "logs is null or invalid"), nil)
                                completion = nil
                                return
                        }
                        
                        guard
                            let rlpItem = try? RLPDecoder().decode(receipt.logs[0].data.bytes),
                            let respBytes = rlpItem.array?[0].bytes else {
                                completion?(PlatonCommonResult.fail(-1, "logs rlp decode error"), nil)
                                completion = nil
                                return
                        }
                        
                        guard
                            let callResponse = try? JSONDecoder().decode(PlatonContractCallResponse<String>.self, from: Data(bytes: respBytes)) else {
                                completion?(PlatonCommonResult.fail(-1, "logs result json decode error"), nil)
                                completion = nil
                            return
                        }
                        
                        guard callResponse.Code == 0 else {
                            completion?(PlatonCommonResult.fail(callResponse.Code, callResponse.errMsg), nil)
                            completion = nil
                            return
                        }
                        
                        DispatchQueue.main.async {
                            completion?(.success, receipt)
                            completion = nil
                        }
                        
                        sema.signal()
                        time = 0
                    case .failure(_):
                        Debugger.debugPrint("fail getTransactionReceipt 😭")
                        if time == 0{
                            DispatchQueue.main.async {
                                completion?(.fail(response.error?.code, response.error?.message), nil)
                                completion = nil
                            }
                            sema.signal()
                            time = 0
                        }
                        sema.signal()
                    }
                }
            } while time > 0
        }
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
                                completion?(PlatonCommonResult.fail(response.error?.code, response.error?.message), nil)
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
