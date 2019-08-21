//
//  Verifier.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import BigInt

public struct Verifier: Codable {
    var NodeId: String?
    var StakingAddress: String?
    var BenefitAddress: String?
    var StakingTxIndex: UInt32?
    var ProgramVersion: UInt32?
    var StakingBlockNum: UInt64?
    var Shares: Decimal?
    var ExternalId: String?
    var NodeName: String?
    var Website: String?
    var Details: String?
    var ValidatorTerm: UInt32?
}
