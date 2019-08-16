//
//  PlatonContractCallResponse.swift
//  platonWeb3Demo
//
//  Created by Admin on 26/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct PlatonContractCallResponse<T: Codable>: Codable {
    var Status: Bool
    var ErrMsg: String
//    var Data: [T]
}
