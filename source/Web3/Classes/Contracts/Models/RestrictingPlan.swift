//
//  RestrictingPlan.swift
//  platonWeb3Demo
//
//  Created by Admin on 9/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

struct RestrictingPlan {
    var epoch: UInt64
    var amount: BigUInt
    
    public enum Error: Swift.Error {
        case rlpItemInvalid
    }
}

extension RLPItem {
    init(epoch: UInt64,
         amount: BigUInt) {
        self = .array(
            .uint(UInt(epoch)),
            .bigUInt(amount)
        )
    }
}

extension RestrictingPlan: RLPItemConvertible {
    init(rlp: RLPItem) throws {
        guard let array = rlp.array, array.count == 2 else {
            throw Error.rlpItemInvalid
        }
        
        guard let epoch = array[0].uint, let amount = array[1].bigUInt else {
            throw Error.rlpItemInvalid
        }
        
        self.init(epoch: UInt64(epoch), amount: amount)
    }
    
    func rlp() throws -> RLPItem {
        return RLPItem(epoch: epoch, amount: amount)
    }
}
