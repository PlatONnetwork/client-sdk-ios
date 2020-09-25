//
//  Verifier.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import BigInt

public struct Verifier: Decodable {
    var NodeId: String?
    var StakingAddress: String?
    var BenefitAddress: String?
    var StakingTxIndex: UInt32?
    var ProgramVersion: UInt32?
    var StakingBlockNum: UInt64?
    var Shares: BigUInt?
    var ExternalId: String?
    var NodeName: String?
    var Website: String?
    var Details: String?
    var ValidatorTerm: UInt32?
    
    enum CodingKeys: String, CodingKey {
        case NodeId
        case StakingAddress
        case BenefitAddress
        case StakingTxIndex
        case ProgramVersion
        case StakingBlockNum
        case Shares
        case ExternalId
        case NodeName
        case Website
        case Details
        case ValidatorTerm
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        NodeId = try? container.decode(String.self, forKey: .NodeId)
        StakingAddress = try? container.decode(String.self, forKey: .StakingAddress)
        BenefitAddress = try? container.decode(String.self, forKey: .BenefitAddress)
        StakingTxIndex = try? container.decode(UInt32.self, forKey: .StakingTxIndex)
        ProgramVersion = try? container.decode(UInt32.self, forKey: .ProgramVersion)
        StakingBlockNum = try? container.decode(UInt64.self, forKey: .StakingBlockNum)
        ExternalId = try? container.decode(String.self, forKey: .ExternalId)
        NodeName = try? container.decode(String.self, forKey: .NodeName)
        Website = try? container.decode(String.self, forKey: .Website)
        Details = try? container.decode(String.self, forKey: .Details)
        ValidatorTerm = try? container.decode(UInt32.self, forKey: .ValidatorTerm)
        
        let sharesHex = try? container.decode(String.self, forKey: .Shares)
        Shares = BigUInt(sharesHex?.remove0xPrefix() ?? "0x0", radix: 16)
    }
}
