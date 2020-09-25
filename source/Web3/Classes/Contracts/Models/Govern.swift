//
//  Govern.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 8/11/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct Govern: Decodable {
    var ParamItem: ParamItem?
    var ParamValue: ParamValue?
}

public struct ParamItem: Decodable {
    var Module: String?
    var Name: String?
    var Desc: String?
}

public struct ParamValue: Decodable {
    var StaleValue: String?
    var Value: String?
    var ActiveBlock: UInt64?
}
