//
//  RestrictingPlanContract.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public class RestrictingPlanContract: PlantonContractProtocol {
    
    var platon: Web3.Platon
    var contractAddress: String
    
    required init(platon: Web3.Platon, contractAddress: String) {
        self.platon = platon
        self.contractAddress = contractAddress
    }
    
    public func createRestrictingPlan(
        account: String,
        plans: [RestrictingPlan],
        sender: String,
        privateKey: String,
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.createRestrictingPlan(account: account, plans: plans)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
    }
    
    public func getRestrictingPlanInfo(
        sender: String,
        account: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<RestrictingInfo>?>?) {
        let funcObject = FuncType.restrictingInfo(account: account)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}

extension RestrictingPlanContract {
    public func getGasCreateRestrictingPlan(
        account: String,
        plans: [RestrictingPlan]) -> BigUInt {
        let funcObject = FuncType.createRestrictingPlan(account: account, plans: plans)
        return funcObject.gas
    }
}

