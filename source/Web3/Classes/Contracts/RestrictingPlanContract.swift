//
//  RestrictingPlanContract.swift
//  platonWeb3Demo
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
    
    func createRestrictingPlan(account: String,
                               plans: [RestrictingPlan],
                               sender: String,
                               privateKey: String,
                               completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.createRestrictingPlan(account: account, plans: plans)
        
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey) { [weak self] (result, data) in
            guard let self = self else { return }
            switch result {
            case .success:
                guard let txHashData = data else {
                    self.failCompletionOnMainThread(code: -1, errorMsg: "data parse error!", completion: &completion)
                    return
                }
                
                self.successCompletionOnMain(obj: txHashData as AnyObject, completion: &completion)
            case .fail(let code, let errMsg):
                self.failCompletionOnMainThread(code: code!, errorMsg: errMsg!, completion: &completion)
            }
        }
    }
    
    func getRestrictingPlanInfo(sender: String,
                                account: String,
                                completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.restrictingInfo(account: account)
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<DelegateInfo>?) in
            guard let self = self else { return }
            switch result {
            case .success:
                print(response)
                break;
            case .fail(let code, let errMsg):
                break;
            }
        }
    }
}

