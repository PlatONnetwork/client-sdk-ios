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
    
    func platonCall<T: Codable>(_ funcType: FuncType, sender: String, completion: Web3.Platon.PlatonCallCompletion<T>?)
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity?, gas: BigUInt?, gasPrice: BigUInt?, completion: Web3.Platon.ContractSendRawCompletion?)
}

extension PlantonContractProtocol {
    func platonCall<T: Codable>(_ funcType: FuncType, sender: String, completion: Web3.Platon.PlatonCallCompletion<T>?) {
        platon.platonCall(contractAddress: contractAddress, from: sender, inputs: funcType.rlpData, completion: completion)
    }
    
    func platonSendRawTransaction(_ funcType: FuncType, sender: String, privateKey: String, value: EthereumQuantity? = nil, gas: BigUInt? = nil, gasPrice: BigUInt? = nil, completion: Web3.Platon.ContractSendRawCompletion?) {
        platon.platonSendRawTransaction(contractAddress: contractAddress, data: funcType.rlpData.bytes, sender: sender, privateKey: privateKey, gasPrice: gasPrice ?? funcType.gasPrice, gas: gas ?? funcType.gas, value: value, estimated: true, completion: completion)
    }
}

//extension PlantonContractProtocol {
//    func platonCall<T: Codable>(inputs: Data, completion: Web3.Platon.PlatonCallCompletion<T>?) {
//        platon.platonCall(contractAddress: contractAddress, from: sender, inputs: inputs, completion: completion)
//    }
//
//    func platonSendRawTransaction(inputs: Data,
//                                  gas: BigUInt,
//                                  gasPrice: BigUInt,
//                                  sender: String,
//                                  privateKey: String,
//                                  value: EthereumQuantity? = nil,
//                                  completion: Web3.Platon.ContractSendRawCompletion?) {
//        platon.platonSendRawTransaction(contractAddress: contractAddress, data: inputs.bytes, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: value, estimated: true, completion: completion)
//    }
//}

extension PlantonContractProtocol {
    func timeOutCompletionOnMainThread(completion: inout PlatonCommonCompletion?) {
        if Thread.current.isMainThread {
            completion?(PlatonCommonResult.fail(-1, Localized("Request_timeout")), nil)
            completion = nil
        } else {
            let semaphore = DispatchSemaphore(value: 0)
            var mc = completion
            DispatchQueue.main.async {
                mc?(PlatonCommonResult.fail(-1, Localized("Request_timeout")),nil)
                mc = nil
                semaphore.signal()
            }
            if semaphore.wait(wallTimeout: .now() + onMainPerformTimeout) == .timedOut{
            }
            completion = nil
        }
    }
    
    public func failCompletionOnMainThread(code: Int, errorMsg: String, completion: inout PlatonCommonCompletion?){
        if Thread.current.isMainThread {
            completion?(PlatonCommonResult.fail(code, errorMsg),nil)
            completion = nil
        } else {
            let semaphore = DispatchSemaphore(value: 0)
            var mc = completion
            DispatchQueue.main.async {
                mc?(PlatonCommonResult.fail(code, errorMsg),nil)
                mc = nil
                semaphore.signal()
            }
            if semaphore.wait(wallTimeout: .now() + onMainPerformTimeout) == .timedOut{
            }
            completion = nil
        }
    }
    
    
    public func failWithEmptyResponseCompletionOnMainThread(completion: inout PlatonCommonCompletion?){
        if Thread.current.isMainThread {
            completion?(PlatonCommonResult.fail(-1, Localized("RPC_Response_empty")),nil)
            completion = nil
        } else {
            let semaphore = DispatchSemaphore(value: 0)
            var mc = completion
            DispatchQueue.main.async {
                mc?(PlatonCommonResult.fail(-1, Localized("RPC_Response_empty")),nil)
                mc = nil
                semaphore.signal()
            }
            if semaphore.wait(wallTimeout: .now() + onMainPerformTimeout) == .timedOut{
            }
            completion = nil
        }
    }
    
    public func successCompletionOnMain(obj : AnyObject?,completion: inout PlatonCommonCompletion?){
        if Thread.current.isMainThread {
            completion?(PlatonCommonResult.success,obj)
            completion = nil
        } else {
            let semaphore = DispatchSemaphore(value: 0)
            var mc = completion
            DispatchQueue.main.async {
                mc?(PlatonCommonResult.success,obj)
                mc = nil
                semaphore.signal()
            }
            if semaphore.wait(wallTimeout: .now() + onMainPerformTimeout) == .timedOut{
            }
            completion = nil
        }
    }
}


