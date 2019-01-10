//
//  Debugger.swift
//  platonWeb3
//
//  Created by Ned on 10/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public class Debugger{
    
    static let instance = Debugger()
    
    public var debugMode = false
    
    public func debugPrint(_ items: Any...){
        if debugMode{
            print(items)
        }
    }
    
    public static func debugPrint(_ items: Any...){
        if Debugger.instance.debugMode{
            print(items)
        }
    }
}
