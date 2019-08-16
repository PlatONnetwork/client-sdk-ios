//
//  ProposalContract.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

enum VoteOption: UInt8 {
    case Yeas = 1
    case Nays = 2
    case Abstentions = 3
}

public class ProposalContract: PlantonContractProtocol {
    
    var platon: Web3.Platon
    var contractAddress: String
    
    required init(platon: Web3.Platon, contractAddress: String) {
        self.platon = platon
        self.contractAddress = contractAddress
    }
    
    func submitText(verifier: String,
                    githubID: String,
                    topic: String,
                    desc: String,
                    url: String,
                    endVotingBlock: UInt64,
                    sender: String,
                    privateKey: String,
                    completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.submitText(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: endVotingBlock)
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
    
    func submitVersion(verifier: String,
                       githubID: String,
                       topic: String,
                       desc: String,
                       url: String,
                       newVersion: UInt,
                       endVotingBlock: UInt64,
                       activeBlock: UInt64,
                       sender: String,
                       privateKey: String,
                       completion: PlatonCommonCompletion?) {
        var completion = completion
        
        let funcObject = FuncType.submitVersion(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, newVersion: newVersion, endVotingBlock: endVotingBlock, activeBlock: activeBlock)
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
    
    func submitParam(verifier: String,
                     githubID: String,
                     topic: String,
                     desc: String,
                     url: String,
                     endVotingBlock: UInt64,
                     paramName: String,
                     currentValue: String,
                     newValue: String,
                     sender: String,
                     privateKey: String,
                     completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.submitParam(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: endVotingBlock, paramName: paramName, currentValue: currentValue, newValue: newValue)
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
    
    func vote(verifier: String,
              proposalID: String,
              option: VoteOption,
              sender: String,
              privateKey: String,
              completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.voteProposal(verifier: verifier, proposalID: proposalID, option: option)
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
    
    func declareVersion(activeNode: String,
                        version: UInt32,
                        sender: String,
                        privateKey: String,
                        completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.declareVersion(activeNode: activeNode, version: version)
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
    
    func getProposal(sender: String,
                     proposalID: String,
                     completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.proposal(proposalID: proposalID)
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
    
    func getProposalResult(sender: String,
                           proposalID: String,
                           completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.proposalResult(proposalID: proposalID)
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
    
    func getProposalList(sender: String,
                         completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.proposalList
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
    
    func getActiveVersion(sender: String,
                          completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.activeVersion
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
    
    func getProgramVersion(sender: String,
                           completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.programVersion
        platonCall(funcObject, sender: sender) { (result, response: PlatonContractCallResponse<Candidate>?) in
            switch result {
            case .success:
                print(response)
                break;
            case .fail(let code, let errMsg):
                break;
            }
        }
    }
    
    func getListParam(sender: String,
                      completion: PlatonCommonCompletion?) {
        var completion = completion
        let funcObject = FuncType.listParam
        platonCall(funcObject, sender: sender) { (result, response: PlatonContractCallResponse<Candidate>?) in
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
