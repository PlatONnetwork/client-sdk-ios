//
//  StackingContract.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public class StakingContract: PlantonContractProtocol {
    
    var contractAddress: String
    var platon: Web3.Platon
    
    required init(platon: Web3.Platon, contractAddress: String) {
        self.platon = platon
        self.contractAddress = contractAddress
    }
    
    func createStaking(typ: UInt16,
                       benifitAddress: String,
                       nodeId: String,
                       externalId: String,
                       nodeName: String,
                       website: String,
                       details: String,
                       amount: BigUInt,
                       sender: String,
                       privateKey: String,
                       completion: PlatonCommonCompletion?) {
        var completion = completion
        
        let funcObject = FuncType.createStaking(typ: typ, benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details, amount: amount)
        print(String(bytes: funcObject.rlpData.bytes))
        
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
    
    func editorStaking(benifitAddress: String,
                       nodeId: String,
                       externalId: String,
                       nodeName: String,
                       website: String,
                       details: String,
                       sender: String,
                       privateKey: String,
                       completion: PlatonCommonCompletion?) {
        var completion = completion
        
        let funcObject = FuncType.editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
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
    
    func increseStaking(nodeId: String,
                        typ: UInt16,
                        amount: BigUInt,
                        sender: String,
                        privateKey: String,
                        completion: PlatonCommonCompletion?) {
        var completion = completion
        
        let funcObject = FuncType.increaseStaking(nodeId: nodeId, typ: typ, amount: amount)
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
    
    
    
    func withdrewStaking(nodeId: String,
                         sender: String,
                         privateKey: String,
                         completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.withdrewStaking(nodeId: nodeId)
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
    
    func createDelegate(typ: UInt16,
                        nodeId: String,
                        amount: BigUInt,
                        sender: String,
                        privateKey: String,
                        completion: PlatonCommonCompletion?) {
        var completion = completion
        
        let funcObject = FuncType.createDelegate(typ: typ, nodeId: nodeId, amount: amount)
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
    
    func withdrewDelegate(stakingBlockNum: UInt64,
                          nodeId: String,
                          amount: BigUInt,
                          sender: String,
                          privateKey: String,
                          completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
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
    
    func getVerifierList(
        sender: String,
        completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.verifierList
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<Verifier>?) in
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
    
    func getValidatorList(
        sender: String,
        completion: PlatonCommonCompletion?) {
        var completion =  completion
        let funcObject = FuncType.validatorList
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<Validator>?) in
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
    
    func getCandidateList(
        sender: String,
        completion: PlatonCommonCompletion?) {
        var completion =  completion
        let funcObject = FuncType.candidateList
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<Candidate>?) in
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
    
    func getDelegateListByDelAddr(sender: String,
                                  addr: String,
                                  completion: PlatonCommonCompletion?) {
        var completion =  completion
        let funcObject = FuncType.delegateListByAddr(addr: addr)
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<RelatedDelegateNode>?) in
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
    
    func getDelegateInfo(sender: String,
                         stakingBlockNum: UInt64,
                         delAddr: String,
                         nodeId: String,
                         completion: PlatonCommonCompletion?) {
        var completion =  completion
        let funcObject = FuncType.delegateInfo(stakingBlockNum: stakingBlockNum, delAddr: delAddr, nodeId: nodeId)
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
    
    func getStakingInfo(sender: String,
                        nodeId: String,
                        completion: PlatonCommonCompletion?) {
        var completion =  completion
        let funcObject = FuncType.stakingInfo(nodeId: nodeId)
        platonCall(funcObject, sender: sender) { [weak self] (result, response: PlatonContractCallResponse<CandidateInfo>?) in
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
