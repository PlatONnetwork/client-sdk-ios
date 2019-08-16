//
//  PlatonConfig.swift
//  platonWeb3Demo
//
//  Created by Admin on 15/8/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

struct PlatonConfig {
    // 初始化的合约地址
    struct ContractAddress {
        static let stakingContractAddress: String = "0x1000000000000000000000000000000000000002"
        static let proposalContractAddress: String = "0x1000000000000000000000000000000000000005"
        static let restrictingContractAddress: String = "0x1000000000000000000000000000000000000001"
        static let slashContractAddress: String = "0x1000000000000000000000000000000000000004"
    }
    
    // 合约消耗交易发送的gas
    struct FuncGas {
        static var defaultGas: BigUInt = BigUInt("21000")!
        static var createStakingGas: BigUInt = BigUInt("32000")!
        static var editorStakingGas: BigUInt = BigUInt("12000")!
        static var increaseStakingGas: BigUInt = BigUInt("20000")!
        static var withdrewStakingGas: BigUInt = BigUInt("20000")!
        static var createDelegateGas: BigUInt = BigUInt("16000")!
        static var withdrewDelegateGas: BigUInt = BigUInt("8000")!
        
        static var submitTextGas: BigUInt = BigUInt("320000")!
        static var submitVersionGas: BigUInt = BigUInt("450000")!
        static var submitParamGas: BigUInt = BigUInt("500000")!
        static var voteProposalGas: BigUInt = BigUInt("2000")!
        static var declareVersionGas: BigUInt = BigUInt("3000")!
        
        static var reportMultiSignGas: BigUInt = BigUInt("1000")!
        static var createRestrictingPlanGas: BigUInt = BigUInt("8000")!
    }
    
    struct FuncGasPrice {
        static var defaultGasPrice: BigUInt = BigUInt("21000")!
    }
    
    struct ContractVersion {
        static let programVersion: UInt32 = UInt32(1792)
    }
    
    struct PlatonChainId {
        static let defaultChainId: String = "100"
    }
}
