//
//  RPCResponse.swift
//  Web3
//
//  Created by Koray Koska on 30.12.17.
//  Copyright © 2018 Boilertalk. All rights reserved.
//

import Foundation

enum Result<T> {
    case codableResult(T)
    case rlpResult(T)
}

public struct RPCError: Swift.Error, Codable {
    
    /// The error code
    public let code: Int
    
    /// The error message
    public let message: String
    
    /// Description
    public var localizedDescription: String {
        return "RPC Error (\(code)) \(message)"
    }
}

public struct RPCResponse<Result: Codable>: Codable {

    /// The rpc id
    public let id: Int

    /// The jsonrpc version. Typically 2.0
    public let jsonrpc: String

    /// The result
    public let result: Result?

    /// The error
    public let error: RPCError?
}

public typealias BasicRPCResponse = RPCResponse<EthereumValue>
