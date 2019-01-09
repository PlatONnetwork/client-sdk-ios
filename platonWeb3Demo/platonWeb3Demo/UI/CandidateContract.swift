//
//  CandidateContract.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import BigInt

class CandidateContract {
    
    func CandidateDeposit(){
        
        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";//节点id
        let owner = "0xf8f3978c14f585c920718c27853e2380d6f5db36"; //质押金退款地址
        let fee = Data.newData(unsignedLong: 500, bigEndian: true) //出块奖励佣金比，以10000为基数(eg：5%，则fee=500)
        let host = "192.168.9.76"; //节点IP
        let port = "26794"; //节点P2P端口号
        
        var extra : Dictionary<String,String> = [:]
        extra["nodeName"] = "xxxx-noedeName"
        extra["nodePortrait"] = "http://192.168.9.86:8082/group2/M00/00/00/wKgJVlr0KDyAGSddAAYKKe2rswE261.png"
        extra["nodeDiscription"] = "xxxx-nodeDiscription"
        extra["nodeDepartment"] = "xxxx-nodeDepartment"
        extra["officialWebsite"] = "https://www.platon.network/"
        
        var theJSONText : String?
        if let theJSONData = try? JSONSerialization.data(withJSONObject: extra,options: []) {
            theJSONText = String(data: theJSONData,
                                     encoding: .ascii)
        }
        let value = BigUInt("500")!
        
        let params = [
            nodeId.data(using: .utf8)!,
            owner.data(using: .utf8),
            fee,
            host.data(using: .utf8),
            port.data(using: .utf8),
            theJSONText!.data(using: .utf8)
                      ]
        
        web3.eth.platonSendRawTransaction(code: ExecuteCode.CampaignPledge, contractAddress: "0x1000000000000000000000000000000000000001", functionName: "CandidateDeposit", params: params as! [Data], sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: EthereumQuantity(quantity: value), estimated: false) { (result, data) in
            switch result{
            case .success:
                print("success: hash: \(String(describing: data?.toHexString()))")
            case .fail(let code, let errorMsg):
                print("error code: \(String(describing: code)), msg:\(String(describing: errorMsg))")
            }
        }
        
    }
    
    func CandidateApplyWithdraw(){
        
    }
}

