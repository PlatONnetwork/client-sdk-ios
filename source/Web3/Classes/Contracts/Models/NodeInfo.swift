//
//  NodeInfo.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

struct DelegateInfo: Codable {
    var Addr: EthereumAddress
    var NodeId: String
    var StakingBlockNum: UInt64
    var DelegateEpoch: UInt32?
    var Released: BigUInt?
    var ReleasedHes: BigUInt?
    var RestrictingPlan: BigUInt?
    var RestrictingPlanHes: BigUInt?
    var Reduction: BigUInt?
}

struct CandidateInfo: Codable {
    var NodeId: String
    var StakingAddress: EthereumAddress
    var BenifitAddress: EthereumAddress
    var StakingTxIndex: UInt32?
    var ProcessVersion: UInt32?
    var Status: UInt32?
    var StakingEpoch: UInt32?
    var StakingBlockNum: UInt64
    var Shares: BigUInt?
    var Released: BigUInt?
    var ReleasedHes: BigUInt?
    var RestrictingPlan: BigUInt?
    var RestrictingPlanHes: BigUInt?
    var ExternalId: String
    var NodeName: String
    var Website: String
    var Details: String
}


