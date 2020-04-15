//
//  PlatonConfig.swift
//  platonWeb3Demo
//
//  Created by Admin on 15/8/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct PlatonConfig {
    // 初始化的合约地址
    public struct ContractAddress {
        public static let stakingContractAddress: String = "0x1000000000000000000000000000000000000002"
        public static let proposalContractAddress: String = "0x1000000000000000000000000000000000000005"
        public static let restrictingContractAddress: String = "0x1000000000000000000000000000000000000001"
        public static let slashContractAddress: String = "0x1000000000000000000000000000000000000004"
        public static let rewardContractAddress: String = "0x1000000000000000000000000000000000000006"
    }
    
    struct ContractCallGas {
        static var stakingContractGas: BigUInt = BigUInt("6000")!
        static var proposalContractGas: BigUInt = BigUInt("9000")!
        static var slashContractGas: BigUInt = BigUInt("21000")!
        static var restrictingContractGas: BigUInt = BigUInt("18000")!
        
        static let createStakingGas: BigUInt = BigUInt("32000")!
        static let editorStakingGas: BigUInt = BigUInt("12000")!
        static let increaseStakingGas: BigUInt = BigUInt("20000")!
        static let withdrewStakingGas: BigUInt = BigUInt("20000")!
        static let createDelegateGas: BigUInt = BigUInt("16000")!
        static let withdrewDelegateGas: BigUInt = BigUInt("8000")!
        
        static let submitTextGas: BigUInt = BigUInt("320000")!
        static let submitVersionGas: BigUInt = BigUInt("450000")!
        static let submitCancelGas: BigUInt = BigUInt("500000")!
        static let submitParamGas: BigUInt = BigUInt("500000")!
        static let voteProposalGas: BigUInt = BigUInt("2000")!
        static let declareVersionGas: BigUInt = BigUInt("3000")!
        
        static let reportMultiSignGas: BigUInt = BigUInt("21000")!
        static let createRestrictingPlanGas: BigUInt = BigUInt("8000")!
    }
    
    // 合约消耗交易发送的gas
    // 内置合约gas消耗 = 21000 + 合约调用固定消耗 + 接口固定gas消耗 + 接口动态gas消耗规则 + (data中的非0值byte个数*68) + (data中的0值byte个数*4)
    public struct FuncGas {
        public static var defaultGas: BigUInt = BigUInt("21000")!
        
        public static var createStakingGas: BigUInt = defaultGas + ContractCallGas.createStakingGas + ContractCallGas.stakingContractGas
        public static var editorStakingGas: BigUInt = defaultGas + ContractCallGas.editorStakingGas + ContractCallGas.stakingContractGas
        public static var increaseStakingGas: BigUInt = defaultGas + ContractCallGas.increaseStakingGas + ContractCallGas.stakingContractGas
        public static var withdrewStakingGas: BigUInt = defaultGas + ContractCallGas.withdrewStakingGas + ContractCallGas.stakingContractGas
        public static var createDelegateGas: BigUInt = defaultGas + ContractCallGas.createDelegateGas + ContractCallGas.stakingContractGas
        public static var withdrewDelegateGas: BigUInt = defaultGas + ContractCallGas.withdrewDelegateGas + ContractCallGas.stakingContractGas
        
        public static var submitTextGas: BigUInt = defaultGas + ContractCallGas.submitTextGas + ContractCallGas.proposalContractGas
        public static var submitVersionGas: BigUInt = defaultGas + ContractCallGas.submitVersionGas + ContractCallGas.proposalContractGas
        public static var submitParamGas: BigUInt = defaultGas + ContractCallGas.submitParamGas + ContractCallGas.proposalContractGas
        public static var submitCancelGas: BigUInt = defaultGas + ContractCallGas.submitCancelGas + ContractCallGas.proposalContractGas
        public static var voteProposalGas: BigUInt = defaultGas + ContractCallGas.voteProposalGas + ContractCallGas.proposalContractGas
        public static var declareVersionGas: BigUInt = defaultGas + ContractCallGas.declareVersionGas + ContractCallGas.proposalContractGas
        
        public static var reportMultiSignGas: BigUInt = defaultGas + ContractCallGas.reportMultiSignGas + ContractCallGas.slashContractGas
        
        public static var createRestrictingPlanGas: BigUInt = defaultGas + ContractCallGas.createRestrictingPlanGas + ContractCallGas.restrictingContractGas
    }
    
    public struct FuncGasPrice {
        public static var minGasPrice: BigUInt = BigUInt("10000000000")!
        public static var defaultGasPrice: BigUInt = BigUInt("500000000000")!
        public static var submitTextGasPrice: BigUInt = BigUInt("1500000")!
        public static var submitVersionGasPrice: BigUInt = BigUInt("2100000")!
        public static var submitCancelGasPrice: BigUInt = BigUInt("3000000")!
        public static var submitParamGasPrice: BigUInt = BigUInt("2000000")!
    }
    
    public struct VON {
        public static let GVON = BigUInt(1000000000)
        public static let LAT = BigUInt(1000000000000000000)
    }
    
    public static let EnableEIP155 = true
}
