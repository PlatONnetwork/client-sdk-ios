//
//  Proposal.swift
//  platonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

struct Proposal: Codable {
    var proposalID: String
    var proposer: String
    var proposalType: UInt8
    var githubID: String
    var topic: String
    var desc: String
    var submitBlock: UInt64
    var endVotingBlock: UInt64
    var activeBlock: UInt64
    var newVersion: UInt
}
