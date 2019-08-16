//
//  Validator.swift
//  platonWeb3Demo
//
//  Created by Admin on 26/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct Validator: Codable {
    var NodeId: String?
    var StakingAddress: String?
    var BenifitAddress: String?
    var StakingTxIndex: UInt32?
    var ProcessVersion: UInt32?
    var StakingBlockNum: UInt32?
    var Shares: String?
    var ExternalId: String?
    var NodeName: String?
    var Website: String?
    var Details: String?
    var ValidatorTerm: UInt32?
}
