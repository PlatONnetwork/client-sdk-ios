//
//  Config.swift
//  Alamofire
//
//  Created by jenkins on 2020/9/24.
//

import Foundation

public enum NetworkParameter {
    
    case mainNet
    case testNet(chainId: String)
    
    public var chainId: String {
        switch self {
        case .testNet(let id):
            return id
        default:
            return "100"
        }
    }
    
    public var unit: String {
        return "LAT"
    }
    
    public var addrPrefix: String {
        switch self {
        case .testNet( _):
            return "lax"
        default:
            return "lat"
        }
    }
    
    public var coinCode: Int {
        return 486
    }

}
