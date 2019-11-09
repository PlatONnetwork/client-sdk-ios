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
        typ: UInt8, // 代表双签类型 1：prepareBlock，2：prepareVote，3：viewChange
        data: String, // 单个证据的json值
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.reportMultiSign(typ: typ, data: data)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func checkDuplicateSign(
        sender: String,
        typ: DuplicateSignType,
        addr: String,
        blockNumber: UInt64,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<String>?>?) {
        let funcObject = FuncType.checkMultiSign(typ: typ.rawValue, addr: addr, blockNumber: blockNumber)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}

extension SlashContract {
    public func estimateReportDoubleSign(
        typ: UInt8,
        data: String,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.reportMultiSign(typ: typ, data: data)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
}
