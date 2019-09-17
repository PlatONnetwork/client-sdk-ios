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
    var ErrMsg: String?
    var Data: String?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case Code
        case ErrMsg
        case Data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Code = try container.decode(Int.self, forKey: .Code)
        ErrMsg = try container.decodeIfPresent(String.self, forKey: .ErrMsg)
        Data = try container.decodeIfPresent(String.self, forKey: .Data)
        
        if let subJSONData = Data?.data(using: .utf8) {
            if T.self == String.self {
                result = Data as? T
            } else {
                result = try? JSONDecoder().decode(T.self, from: subJSONData)
            }
        }
    }
}


