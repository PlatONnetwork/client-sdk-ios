//
//  PlatonContractCallResponse.swift
//  platonWeb3Demo
//
//  Created by Admin on 26/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public struct PlatonContractCallResponse<T: Decodable>: Decodable {
    var Status: Bool
    var ErrMsg: String?
    var Data: String?
    var result: T?
    
    enum CodingKeys: String, CodingKey {
        case Status
        case ErrMsg
        case Data
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        Status = try container.decode(Bool.self, forKey: .Status)
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


