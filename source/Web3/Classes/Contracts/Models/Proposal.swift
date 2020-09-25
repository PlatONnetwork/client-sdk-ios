//
//  Proposal.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 10/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

// 文本提案
public struct Proposal: Codable {
    var ProposalID: String?
    var Proposer: String?
    var ProposalType: UInt8?
    var PIPID: String?
    var SubmitBlock: UInt64?
    var EndVotingBlock: UInt64?
    var EndVotingRounds: UInt64?
    var ActiveBlock: UInt64?
    var NewVersion: UInt?
    var TobeCanceled:String?
}
