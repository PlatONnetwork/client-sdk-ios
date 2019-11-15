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
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
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

        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
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
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
    }
    
    public func increseStaking(
        nodeId: String,
        typ: UInt16,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.increaseStaking(nodeId: nodeId, typ: typ, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
    }
    
    public func withdrewStaking(
        nodeId: String,
        sender: String,
        privateKey: String,
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {

        let funcObject = FuncType.withdrewStaking(nodeId: nodeId)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
    }
    
    public func createDelegate(
        typ: UInt16,
        nodeId: String,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.createDelegate(typ: typ, nodeId: nodeId, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
    }
    
    public func withdrewDelegate(
        stakingBlockNum: UInt64,
        nodeId: String,
        amount: BigUInt,
        sender: String,
        privateKey: String,
        gas: BigUInt? = nil,
        gasPrice: BigUInt? = nil,
        completion: PlatonCommonCompletionV2<Data?>?) {
        
        let funcObject = FuncType.withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
        platonSendRawTransaction(funcObject, sender: sender, privateKey: privateKey, gas: gas, gasPrice: gasPrice, completion: completion)
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
    public func getGasCreateStaking(
        typ: UInt16,
        benifitAddress: String,
        nodeId: String,
        externalId: String,
        nodeName: String,
        website: String,
        details: String,
        amount: BigUInt,
        blsPubKey: String,
        blsProof: String,
        programVersion: UInt32,
        programVersionSign: String) -> BigUInt {

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
        return funcObject.gas
    }
    
    public func getGasEditorStaking(
        benifitAddress: String,
        nodeId: String,
        externalId: String,
        nodeName: String,
        website: String,
        details: String) -> BigUInt {
        let funcObject = FuncType.editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
        return funcObject.gas
    }
    
    public func getGasIncreseStaking(
        nodeId: String,
        typ: UInt16,
        amount: BigUInt) -> BigUInt {
        let funcObject = FuncType.increaseStaking(nodeId: nodeId, typ: typ, amount: amount)
        return funcObject.gas
    }

    public func getGasWithdrewStaking(
        nodeId: String,
        gasPrice: BigUInt? = nil) -> BigUInt {
        let funcObject = FuncType.withdrewStaking(nodeId: nodeId)
        return funcObject.gas
    }

    public func getGasCreateDelegate(
        typ: UInt16,
        nodeId: String,
        amount: BigUInt) -> BigUInt {
        let funcObject = FuncType.createDelegate(typ: typ, nodeId: nodeId, amount: amount)
        return funcObject.gas
    }
    
    public func getGasWithdrawDelegate(
        stakingBlockNum: UInt64,
        nodeId: String,
        amount: BigUInt) -> BigUInt {
        let funcObject = FuncType.withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
        return funcObject.gas
    }
    
}
