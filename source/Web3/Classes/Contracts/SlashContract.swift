//
//  SlashContract.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public class SlashContract: PlantonContractProtocol {
    
    var platon: Web3.Platon
    var contractAddress: String
    
    required init(platon: Web3.Platon, contractAddress: String) {
        self.platon = platon
        self.contractAddress = contractAddress
    }
    
    public func reportDuplicateSign(
        data: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.reportMultiSign(data: data)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func checkDuplicateSign(
        sender: String,
        typ: UInt32,
        addr: String,
        blockNumber: UInt64,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<Data>?>?) {
        let funcObject = FuncType.checkMultiSign(typ: typ, addr: addr, blockNumber: blockNumber)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}

extension SlashContract {
    public func estimateReportDoubleSign(data: String,
                                         completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.reportMultiSign(data: data)
        platonContractEstimateGas(funcObject, completion: completion)
    }
}
