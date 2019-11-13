//
//  ProposalContract.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public enum VoteOption: UInt8 {
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
    
    public func submitText(
        verifier: String,
        pIDID: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.submitText(verifier: verifier, pIDID: pIDID)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func submitVersion(
        verifier: String,
        pIDID: String,
        newVersion: UInt32,
        endVotingBlock: UInt64,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.submitVersion(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingBlock: endVotingBlock)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }

    public func submitParam(
        verifier: String,
        pIDID: String,
        module: String,
        name: String,
        newValue: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        let funcObject = FuncType.submitParam(verifier: verifier, pIDID: pIDID, module: module, name: name, newValue: newValue)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func submitCancel(
        verifier: String,
        pIDID: String,
        newVersion: UInt32,
        endVotingRounds: UInt64,
        tobeCanceledProposalID: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.submitCancel(verifier: verifier, pIDID: pIDID, endVotingRounds: endVotingRounds, tobeCanceledProposalID: tobeCanceledProposalID)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func vote(
        verifier: String,
        proposalID: String,
        option: VoteOption,
        sender: String,
        privateKey: String,
        programVersion: UInt32,
        versionSign: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.voteProposal(
            verifier: verifier,
            proposalID: proposalID,
            option: option,
            programVersion: programVersion,
            versionSign: versionSign
        )

        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func declareVersion(
        verifier: String,
        sender: String,
        privateKey: String,
        programVersion: UInt32,
        versionSign: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.declareVersion(verifier: verifier, programVersion: programVersion, versionSign: versionSign)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func getProposal(
        sender: String,
        proposalID: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<Proposal>?>?) {
        let funcObject = FuncType.proposal(proposalID: proposalID)
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getProposalResult(
        sender: String,
        proposalID: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<TallyResult>?>?) {
        let funcObject = FuncType.proposalResult(proposalID: proposalID)
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getProposalList(
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[Proposal]>?>?) {
        let funcObject = FuncType.proposalList
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getActiveVersion(
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<String>?>?) {
        let funcObject = FuncType.activeVersion
        platonCall(funcObject, sender: sender, completion: completion)
    }

    public func getGovernParamValue(
        module: String,
        name: String,
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<String>?>?) {
        let funcObject = FuncType.getGovernParamValue(module: module, name: name)
        platonCall(funcObject, sender: sender, completion: completion)
    }

    public func getAccuVerifiersCount(
        proposalID: String,
        blockHash: String,
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[UInt16]>?>?) {
        let funcObject = FuncType.getAccuVerifiersCount(proposalID: proposalID, blockHash: blockHash)
        platonCall(funcObject, sender: sender, completion: completion)
    }

    public func listGovernParam(
        module: String,
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[Govern]>?>?) {
        let funcObject = FuncType.listGovernParam(module: module)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}

extension ProposalContract {
    public func estimateSubmitText(
        verifier: String,
        pIDID: String,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.submitText(verifier: verifier, pIDID: pIDID)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateSubmitVersion(
        verifier: String,
        pIDID: String,
        newVersion: UInt32,
        endVotingBlock: UInt64,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.submitVersion(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingBlock: endVotingBlock)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }

    public func estimateSubmitParam(
        verifier: String,
        pIDID: String,
        module: String,
        name: String,
        newValue: String,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.submitParam(verifier: verifier, pIDID: pIDID, module: module, name: name, newValue: newValue)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateSubmitCancel(
        verifier: String,
        pIDID: String,
        newVersion: UInt32,
        endVotingRounds: UInt64,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.submitVersion(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingBlock: endVotingRounds)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateVote(
        verifier: String,
        proposalID: String,
        option: VoteOption,
        sender: String,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        
        platon.getProgramVersion { [weak self] (response) in
            guard let self = self else { return }
            switch response.status {
            case .success:
                if
                    let programVersion = response.result,
                    let PV = programVersion.Version,
                    let PVS = programVersion.Sign {
                    
                    let funcObject = FuncType.voteProposal(verifier: verifier, proposalID: proposalID, option: option, programVersion: PV, versionSign: PVS)
                    self.platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
                }
            case .failure(let error):
                completion?(PlatonCommonResult.fail(error.code, error.message), nil)
            }
        }
    }
    
    public func estimateDeclareVersion(
        verifier: String,
        sender: String,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        
        platon.getProgramVersion { [weak self] (response) in
            guard let self = self else { return }
            switch response.status {
            case .success:
                if
                    let programVersion = response.result,
                    let PV = programVersion.Version,
                    let PVS = programVersion.Sign {
                    
                    let funcObject = FuncType.declareVersion(verifier: verifier, programVersion: PV, versionSign: PVS)
                    self.platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
                }
            case .failure(let error):
                completion?(PlatonCommonResult.fail(error.code, error.message), nil)
            }
        }
    }
}
