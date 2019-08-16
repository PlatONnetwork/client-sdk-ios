//
//  TallyResult.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

struct TallyResult: Codable {
    var proposalID: String
    var yeas: UInt16
    var nays: UInt16
    var abstentions: UInt16
    var accuVerifiers: UInt16
    var status: UInt8
}
