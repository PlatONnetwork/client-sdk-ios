//
//  UInt+ETH.swift
//  Web3
//
//  Created by Koray Koska on 09.02.18.
//  Copyright © 2018 Boilertalk. All rights reserved.
//

import Foundation
import BigInt

public extension BigUInt {

    public var lat: BigUInt {
        return self * BigUInt(10).power(18)
    }

    public var gvon: BigUInt {
        return self * BigUInt(10).power(9)
    }
}

public extension UnsignedInteger {

    public var lat: BigUInt {
        return BigUInt(self).lat
    }

    public var gvon: BigUInt {
        return BigUInt(self).gvon
    }
}

public extension SignedInteger {

    public var lat: BigUInt {
        guard self >= 0 else {
            return 0
        }
        return BigUInt(self).lat
    }

    public var gvon: BigUInt {
        guard self >= 0 else {
            return 0
        }
        return BigUInt(self).gvon
    }
}
