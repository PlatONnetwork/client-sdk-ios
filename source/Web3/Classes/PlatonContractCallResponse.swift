//
//  PlatonContractCallResponse.swift
//  platonWeb3Demo
//
//  Created by Admin on 26/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct PlatonContractCallResponse<T: Decodable>: Decodable {
    var Code: Int
    var errMsg: String?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case Code
        case Ret
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Code = try container.decode(Int.self, forKey: .Code)

        if Code == 0 {
            result = try container.decodeIfPresent(T.self, forKey: .Ret)
        } else {
            errMsg = try container.decodeIfPresent(String.self, forKey: .Ret)
        }
    }
}


