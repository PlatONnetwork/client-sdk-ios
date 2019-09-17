//
//  web3+completion.swift
//  platonWallet
//
//  Created by Ned on 8/12/2018.
//  Copyright © 2018 ju. All rights reserved.
//

import Foundation


public enum PlatonCommonResult : Error{
    case success
    case fail(Int?, String?)
}

public typealias PlatonCommonCompletionV2<T> = (_ result: PlatonCommonResult, _ data: T) -> Void
public typealias PlatonCommonCompletion = (_ result : PlatonCommonResult, _ obj : AnyObject?) -> ()


