//
//  firstdemo.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

class firstdemo{
    
    var contractAddress : String?
    
    var deployHash : String?
    
    var invokeNotifyHash : String?
    
    func getABI() -> String?{
        
        let abiPath = Bundle.main.path(forResource: "assets/firstdemo.cpp.abi", ofType: "json")
        var abiS = try? String(contentsOfFile: abiPath!)
        abiS = abiS?.replacingOccurrences(of: "\r\n", with: "")
        abiS = abiS?.replacingOccurrences(of: "\n", with: "")
        abiS = abiS?.replacingOccurrences(of: " ", with: "")
        
        return abiS
    }
    
    func getBIN() -> Data?{
        let binPath = Bundle.main.path(forResource: "assets/firstdemo", ofType: "wasm")
        let bin = try? Data(contentsOf: URL(fileURLWithPath: binPath!))
        return bin
    }
    
    //MARK: - Contract methods
    
//    func invokeNotify(msg: String){
//        
//        guard contractAddress != nil else {
//            print("ERROR:deploy contract first!")
//            return
//        }
//        
//        let msg_s = SolidityWrappedValue.string(msg)
//        let msg_d = Data(hex: msg_s.value.abiEncode(dynamic: false)!)
//        
//        web3.platon.platonSendRawTransaction(code: ExecuteCode.ContractExecute, contractAddress: self.contractAddress!, functionName: "invokeNotify", params: [msg_d], sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: nil, estimated: false) { (result, data) in
//            switch result{
//            case .success:
//                print("transaction success, hash: \(String(describing: data?.toHexString()))")
//                self.invokeNotifyHash = data?.toHexString()
//            case .fail(let code, let errorMsg):
//                print("error code: \(String(describing: code)), msg:\(String(describing: errorMsg))")
//            }
//        }
//    }
    
    func Notify(){
        guard self.invokeNotifyHash != nil else {
            print("ERROR:invoke invokeNotify first!")
            return
        }
        web3.platon.platonGetTransactionReceipt(txHash: self.invokeNotifyHash!, loopTime: 15) { (result, data) in
            switch result{
            case .success:
                if let receipt = data as? EthereumTransactionReceiptObject{
                    let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                    let code = ABI.uint64Decode(data: Data(rlpItem!.array![0].bytes!))
                    let message = ABI.stringDecode(data: Data(rlpItem!.array![1].bytes!))
                    print("code:\(code) message:\(message)")
                }
            case .fail(let code, let errorMsg):
                print("error code: \(String(describing: code)), msg:\(String(describing: errorMsg))")
            }
        }
    }
}
