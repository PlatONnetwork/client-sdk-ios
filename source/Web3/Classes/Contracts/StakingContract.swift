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
    
    public func createStaking(
        typ: UInt16,
        benifitAddress: String,
        nodeId: String,
        externalId: String,
        nodeName: String,
        website: String,
        details: String,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        programVersion: UInt32,
        programVersionSign: String,
        blsPubKey: String,
        blsProof: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.createStaking(
            typ: typ,
            benifitAddress: benifitAddress,
            nodeId: nodeId,
            externalId: externalId,
            nodeName: nodeName,
            website: website,
            details: details,
            amount: amount,
            programVersion: programVersion,
            programVersionSign: programVersionSign,
            blsPubKey:blsPubKey,
            blsProof: blsProof
        )

        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func editorStaking(
        benifitAddress: String,
        nodeId: String,
        externalId: String,
        nodeName: String,
        website: String,
        details: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func increseStaking(
        nodeId: String,
        typ: UInt16,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.increaseStaking(nodeId: nodeId, typ: typ, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func withdrewStaking(
        nodeId: String,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.withdrewStaking(nodeId: nodeId)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func createDelegate(
        typ: UInt16,
        nodeId: String,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.createDelegate(typ: typ, nodeId: nodeId, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func withdrewDelegate(
        stakingBlockNum: UInt64,
        nodeId: String,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, completion: completion)
    }
    
    public func getVerifierList(
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[Verifier]>?>?) {
        let funcObject = FuncType.verifierList
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getValidatorList(
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[Verifier]>?>?) {
        let funcObject = FuncType.validatorList
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getCandidateList(
        sender: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[CandidateInfo]>?>?) {
        let funcObject = FuncType.candidateList
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getDelegateListByDelAddr(
        sender: String,
        addr: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<[RelatedDelegateNode]>?>?) {
        let funcObject = FuncType.delegateListByAddr(addr: addr)
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getDelegateInfo(
        sender: String,
        stakingBlockNum: UInt64,
        delAddr: String,
        nodeId: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<DelegateInfo>?>?) {
        let funcObject = FuncType.delegateInfo(stakingBlockNum: stakingBlockNum, delAddr: delAddr, nodeId: nodeId)
        platonCall(funcObject, sender: sender, completion: completion)
    }
    
    public func getStakingInfo(
        sender: String,
        nodeId: String,
        completion: PlatonCommonCompletionV2<PlatonContractCallResponse<CandidateInfo>?>?) {
        let funcObject = FuncType.stakingInfo(nodeId: nodeId)
        platonCall(funcObject, sender: sender, completion: completion)
    }
}

extension StakingContract {
    public func estimateCreateStaking(typ: UInt16,
                              benifitAddress: String,
                              nodeId: String,
                              externalId: String,
                              nodeName: String,
                              website: String,
                              details: String,
                              amount: BigUInt,
                              blsPubKey: String,
                              blsProof: String,
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
                    
                    
                    let funcObject = FuncType.createStaking(
                        typ: typ,
                        benifitAddress: benifitAddress,
                        nodeId: nodeId,
                        externalId: externalId,
                        nodeName: nodeName,
                        website: website,
                        details: details,
                        amount: amount,
                        programVersion: PV,
                        programVersionSign: PVS,
                        blsPubKey:blsPubKey,
                        blsProof: blsProof
                    )
                    
                    self.platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
                }
            case .failure(let error):
                completion?(PlatonCommonResult.fail(error.code, error.message), nil)
            }
        }
    }
    
    public func estimateEditorStaking(benifitAddress: String,
                              nodeId: String,
                              externalId: String,
                              nodeName: String,
                              website: String,
                              details: String,
                              gasPrice: BigUInt? = nil,
                              completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateIncreseStaking(nodeId: String,
                               typ: UInt16,
                               amount: BigUInt,
                               gasPrice: BigUInt? = nil,
                               completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.increaseStaking(nodeId: nodeId, typ: typ, amount: amount)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    
    
    public func estimateWithdrewStaking(nodeId: String,
                                        gasPrice: BigUInt? = nil,
                                        completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.withdrewStaking(nodeId: nodeId)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateCreateDelegate(typ: UInt16,
                               nodeId: String,
                               amount: BigUInt,
                               gasPrice: BigUInt? = nil,
                               completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.createDelegate(typ: typ, nodeId: nodeId, amount: amount)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
    public func estimateWithdrawDelegate(stakingBlockNum: UInt64,
                                 nodeId: String,
                                 amount: BigUInt,
                                 gasPrice: BigUInt? = nil,
                                 completion: PlatonCommonCompletionV2<BigUInt?>?) {
        let funcObject = FuncType.withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
        platonContractEstimateGas(funcObject, gasPrice: gasPrice, completion: completion)
    }
    
}
