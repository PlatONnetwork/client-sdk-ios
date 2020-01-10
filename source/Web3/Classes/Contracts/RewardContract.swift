//
//  RewardContract.swift
//  platonWeb3
//
//  Created by Admin on 7/1/2020.
//  Copyright © 2020 ju. All rights reserved.
//

import Foundation

public class RewardContract: PlantonContractProtocol {
    var contractAddress: String
    var platon: Web3.Platon

    required init(platon: Web3.Platon, contractAddress: String) {
        self.platon = platon
        self.contractAddress = contractAddress
    }

    public func withdrawDelegateReward(sender: String, privateKey: String, gasLimit: BigUInt? = nil, gasPrice: BigUInt? = nil, completon: PlatonCommonCompletionV2<Data?>?) {
        let funcObject = FuncType.withdrawDelegateReward
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gasLimit ?? funcObject.gas, gasPrice: gasPrice ?? funcObject.gasPrice, completion: completon)
    }

    public func getDelegateReward(address: String, nodeIDs: [String], sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[RewardRecord]>?>?) {
        let funcObject = FuncType.getDelegateReward(address: address, nodeIDs: nodeIDs)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}
