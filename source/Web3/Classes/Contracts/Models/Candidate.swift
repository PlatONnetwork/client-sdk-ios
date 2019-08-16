//
//  Candidate.swift
//  platonWeb3Demo
//
//  Created by Admin on 26/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct Candidate: Codable {
    var NodeId: String
    var StakingAddress: String
    var BenifitAddress: String
    var StakingTxIndex: UInt32
    var ProcessVersion: UInt32
    var Status: UInt32
    var StakingEpoch: UInt32
    var StakingBlockNum: UInt32?
    var Shares: String
    var Released: BigUInt
    var ReleasedHes: BigUInt
    var RestrictingPlan: BigUInt
    var RestrictingPlanHes: BigUInt
    var ExternalId: String
    var NodeName: String
    var Website: String
    var Details: String
}
