//
//  GlobalConfig.swift
//  PlatonWeb3
//
//  Created by jenkins on 2020/9/27.
//

import Foundation

public class GlobalConfig {
    
    public static let shared = PlatonConfig()
    
    public init() {}
    
    public var unitName: String = ""
    // Default: LAT
    public static var unit: String = "LAT"
}
