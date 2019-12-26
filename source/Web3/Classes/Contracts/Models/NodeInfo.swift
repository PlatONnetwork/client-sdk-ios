//
//  NodeInfo.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct DelegateInfo: Decodable {
    var Addr: String?
    var NodeId: String?
    var StakingBlockNum: UInt64?
    var DelegateEpoch: UInt32?
    var Released: BigUInt?
    var ReleasedHes: BigUInt?
    var RestrictingPlan: BigUInt?
    var RestrictingPlanHes: BigUInt?
    var Reduction: BigUInt?
    
    enum CodingKeys: String, CodingKey {
        case Addr
        case NodeId
        case StakingBlockNum
        case DelegateEpoch
        case Released
        case ReleasedHes
        case RestrictingPlan
        case RestrictingPlanHes
        case Reduction
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Addr = try? container.decode(String.self, forKey: .Addr)
        NodeId = try? container.decode(String.self, forKey: .NodeId)
        StakingBlockNum = try? container.decode(UInt64.self, forKey: .StakingBlockNum)
        DelegateEpoch = try? container.decode(UInt32.self, forKey: .DelegateEpoch)
        
        let releasedHex = try? container.decode(String.self, forKey: .Released)
        Released = BigUInt(releasedHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let releasedHesHex = try? container.decode(String.self, forKey: .ReleasedHes)
        ReleasedHes = BigUInt(releasedHesHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let restrictingPlanHex = try? container.decode(String.self, forKey: .RestrictingPlan)
        RestrictingPlan = BigUInt(restrictingPlanHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let restrictingPlanHesHex = try? container.decode(String.self, forKey: .RestrictingPlanHes)
        RestrictingPlanHes = BigUInt(restrictingPlanHesHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let reductionHex = try? container.decode(String.self, forKey: .Reduction)
        Reduction = BigUInt(reductionHex?.remove0xPrefix() ?? "0x0", radix: 16)
    }
}

public struct CandidateInfo: Decodable {
    var NodeId: String?
    var StakingAddress: String?
    var BenefitAddress: String?
    var StakingTxIndex: UInt32?
    var ProcessVersion: UInt32?
    var Status: UInt32?
    var StakingEpoch: UInt32?
    var StakingBlockNum: UInt64?
    var Shares: BigUInt?
    var Released: BigUInt?
    var ReleasedHes: BigUInt?
    var RestrictingPlan: BigUInt?
    var RestrictingPlanHes: BigUInt?
    var ExternalId: String?
    var NodeName: String?
    var Website: String?
    var Details: String?
    
    enum CodingKeys: String, CodingKey {
        case NodeId
        case StakingAddress
        case BenefitAddress
        case StakingTxIndex
        case ProcessVersion
        case Status
        case StakingEpoch
        case StakingBlockNum
        case Shares
        case Released
        case ReleasedHes
        case RestrictingPlan
        case RestrictingPlanHes
        case ExternalId
        case NodeName
        case Website
        case Details
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        NodeId = try? container.decode(String.self, forKey: .NodeId)
        StakingAddress = try? container.decode(String.self, forKey: .StakingAddress)
        BenefitAddress = try? container.decode(String.self, forKey: .BenefitAddress)
        StakingTxIndex = try? container.decode(UInt32.self, forKey: .StakingTxIndex)
        Status = try? container.decode(UInt32.self, forKey: .Status)
        StakingEpoch = try? container.decode(UInt32.self, forKey: .StakingEpoch)
        StakingBlockNum = try? container.decode(UInt64.self, forKey: .StakingBlockNum)
        ExternalId = try? container.decode(String.self, forKey: .ExternalId)
        NodeName = try? container.decode(String.self, forKey: .NodeName)
        Website = try? container.decode(String.self, forKey: .Website)
        Details = try? container.decode(String.self, forKey: .Details)
        
        let sharesHex = try? container.decode(String.self, forKey: .Shares)
        Shares = BigUInt(sharesHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let releasedHex = try? container.decode(String.self, forKey: .Released)
        Released = BigUInt(releasedHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let releasedHesHex = try? container.decode(String.self, forKey: .ReleasedHes)
        ReleasedHes = BigUInt(releasedHesHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let restrictingPlanHex = try? container.decode(String.self, forKey: .RestrictingPlan)
        RestrictingPlan = BigUInt(restrictingPlanHex?.remove0xPrefix() ?? "0x0", radix: 16)
        
        let restrictingPlanHesHex = try? container.decode(String.self, forKey: .RestrictingPlanHes)
        RestrictingPlanHes = BigUInt(restrictingPlanHesHex?.remove0xPrefix() ?? "0x0", radix: 16)
    }
}


