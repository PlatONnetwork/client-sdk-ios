//
//  NodeInfo.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct DelegateInfo: Codable {
    var Addr: String?
    var NodeId: String?
    var StakingBlockNum: UInt64?
    var DelegateEpoch: UInt32?
    var Released: Decimal?
    var ReleasedHes: Decimal?
    var RestrictingPlan: Decimal?
    var RestrictingPlanHes: Decimal?
    var Reduction: Decimal?
}

public struct CandidateInfo: Codable {
    var NodeId: String?
    var StakingAddress: String?
    var BenifitAddress: String?
    var StakingTxIndex: UInt32?
    var ProcessVersion: UInt32?
    var Status: UInt32?
    var StakingEpoch: UInt32?
    var StakingBlockNum: UInt64?
    var Shares: Decimal?
    var Released: Decimal?
    var ReleasedHes: Decimal?
    var RestrictingPlan: Decimal?
    var RestrictingPlanHes: Decimal?
    var ExternalId: String?
    var NodeName: String?
    var Website: String?
    var Details: String?
}


