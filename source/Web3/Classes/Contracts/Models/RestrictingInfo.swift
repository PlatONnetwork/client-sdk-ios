//
//  RestrictingInfo.swift
//  platonWeb3Demo
//
//  Created by Admin on 20/8/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct RestrictingInfo: Decodable {
    var balance: Decimal?
    var debt: Decimal?
    var symbol: Bool?
    var info: Bytes
}
