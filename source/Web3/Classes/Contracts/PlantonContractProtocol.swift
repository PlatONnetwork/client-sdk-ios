//
//  PlantonContractProtocol.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import Localize_Swift

protocol PlantonContractProtocol {
    var contractAddress: String { get }
    var platon: Web3.Platon { get }
    
    init(platon: Web3.Platon, contractAddress: String)
    
    func platonCall<T: Decodable>(_ funcType: FuncType, sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<T>?>?)
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity?, gas: BigUInt?, gasPrice: BigUInt?, completion: PlatonCommonCompletionV2<Data?>?)
    
    func platonContractEstimateGas(_ funcType: FuncType, completion: PlatonCommonCompletionV2<BigUInt?>?)

    func platonGetProgramVersion(sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<ProgramVersion>?>?)
}

extension PlantonContractProtocol {
    func platonCall<T: Decodable>(_ funcType: FuncType, sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<T>?>?) {
        platon.platonCall(contractAddress: contractAddress, from: sender, inputs: funcType.rlpData, completion: completion)
    }
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity? = nil, gas: BigUInt? = nil, gasPrice: BigUInt? = nil, completion: PlatonCommonCompletionV2<Data?>?) {
        platon.platonSendRawTransaction(contractAddress: contractAddress, data: funcType.rlpData.bytes, sender: sender, privateKey: privateKey, gasPrice: gasPrice ?? funcType.gasPrice, gas: gas ?? funcType.gas, value: value, estimated: true, completion: completion)
    }
    
    func platonContractEstimateGas(_ funcType: FuncType, completion: PlatonCommonCompletionV2<BigUInt?>?) {
        var completion = completion
        let estimateGas = funcType.gas.multiplied(by: funcType.gasPrice)
        DispatchQueue.main.async {
            completion?(.success, estimateGas)
            completion = nil
        }
    }
    
    func platonGetProgramVersion(sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<ProgramVersion>?>?) {
        let funcObject = FuncType.programVersion
        platon.platonCall(contractAddress: PlatonConfig.ContractAddress.proposalContractAddress, from: sender, inputs: funcObject.rlpData, completion: completion)
    }
}
