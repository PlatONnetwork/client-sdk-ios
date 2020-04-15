//
//  RewardRecord.swift
//  platonWeb3
//
//  Created by Admin on 7/1/2020.
//  Copyright © 2020 ju. All rights reserved.
//

import Foundation
import BigInt

public struct RewardRecord: Decodable {
    var nodeID: String?
    var reward: String?
    var stakingNum: UInt64?
}
