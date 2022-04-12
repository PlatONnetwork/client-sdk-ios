//
//  PlantonContractProtocol.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

protocol PlantonContractProtocol {
    var contractAddress: String { get }
    var platon: Web3.Platon { get }
    
    init(platon: Web3.Platon, contractAddress: String)
    
    func platonCall<T: Decodable>(_ funcType: FuncType, sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<T>?>?)
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity?, gas: BigUInt?, gasPrice: BigUInt?, completion: PlatonCommonCompletionV2<Data?>?)
    
    func platonContractEstimateGas(_ funcType: FuncType, gasPrice: BigUInt?, completion: PlatonCommonCompletionV2<BigUInt?>?)
}

extension PlantonContractProtocol {
    func platonCall<T: Decodable>(_ funcType: FuncType, sender: String, completion: PlatonCommonCompletionV2<PlatonContractCallResponse<T>?>?) {
        platon.platonCall(contractAddress: contractAddress, from: sender, inputs: funcType.rlpData, completion: completion)
    }
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity? = nil, gas: BigUInt? = nil, gasPrice: BigUInt? = nil, completion: PlatonCommonCompletionV2<Data?>?) {
        platon.platonSendRawTransaction(contractAddress: contractAddress, data: funcType.rlpData.bytes, sender: sender, privateKey: privateKey, gasPrice: gasPrice ?? funcType.gasPrice, gas: gas ?? funcType.gas, value: value, estimated: true, completion: completion)
    }
    
    func platonContractEstimateGas(_ funcType: FuncType, gasPrice: BigUInt? = nil, completion: PlatonCommonCompletionV2<BigUInt?>?) {
        var completion = completion
        
        switch funcType {
        case .submitText,
             .submitVersion,
             .submitCancel:
            DispatchQueue.main.async {
                completion?(.success, funcType.gas.multiplied(by: funcType.gasPrice ?? PlatonConfig.FuncGasPrice.defaultGasPrice))
                completion = nil
            }
        default:
            if let price = gasPrice {
                DispatchQueue.main.async {
                    completion?(.success, funcType.gas.multiplied(by: price))
                    completion = nil
                }
            } else {
                platon.gasPrice { (response) in
                    switch response.status {
                    case .success(let result):
                        PlatonConfig.FuncGasPrice.defaultGasPrice = result.quantity
                    case .failure(_):
                        break
                    }
                    DispatchQueue.main.async {
                        completion?(.success, funcType.gas.multiplied(by: funcType.gasPrice ?? PlatonConfig.FuncGasPrice.defaultGasPrice))
                        completion = nil
                    }
                }
            }
        }
    }
}
