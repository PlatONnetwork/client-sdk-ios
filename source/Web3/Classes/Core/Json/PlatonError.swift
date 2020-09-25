//
//  PlatonError.swift
//  PlatonWeb3Demo
//
//  Created by Admin on 17/9/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import Localize_Swift

public protocol PlatonError: Error {
    var code: Int { get }
    var message: String { get }
}

public enum Web3Error: PlatonError {
    case emptyResponse
    case requestFailed(Error?)
    case connectionFailed(Error?)
    case serverError(Error?)
    case decodingError(Error?)
    case rpcError(RPCError)
    case emptyNonce
    case signedTxError
    case requestTimeout(Error?)
    case reponseTimeout(Error?)
    
    public var code: Int {
        switch self {
        case .emptyResponse:
            return -1000
        case .requestFailed:
            return -1001
        case .connectionFailed:
            return -1002
        case .serverError:
            return -1003
        case .decodingError:
            return -1004
        case .rpcError(let error):
            return error.code
        case .emptyNonce:
            return -1005
        case .signedTxError:
            return -1006
        case .requestTimeout:
            return -10001
        case .reponseTimeout:
            return -10002
        }
    }
    
    public var message: String {
        switch self {
        case .emptyResponse:
            return Localized("RPC_Response_empty")
        case .requestFailed:
            return Localized("RPC_Response_requestFailed")
        case .connectionFailed:
            return Localized("RPC_Response_connectionFailed")
        case .serverError:
            return Localized("RPC_Response_serverError")
        case .decodingError:
            return Localized("RPC_Response_decodingError")
        case .rpcError(let error):
            return error.message
        case .emptyNonce:
            return "empty nonce"
        case .signedTxError:
            return "signed transaction error"
        case .requestTimeout:
            return Localized("RPC_Response_connectionTimeout")
        case .reponseTimeout:
            return "response timeout"
        }
    }
}

public let statusCodeDescriptions = [
    0: "ok",
    1: "System error",
    2: "Object no found",
    3: "Invalid parameter",
    
    301000: "The bls public key len is wrong",
    301001: "The bls public key proof is wrong",
    301002: "The Description length is wrong",
    301003: "The program version sign is wrong",
    301004: "The program version of the relates node's is too low",
    301005: "DeclareVersion is failed on create staking",
    301006: "The address must be the same as initiated staking",
    
    301100: "Staking deposit too low",
    301101: "This candidate is already exist",
    301102: "This candidate is not exist",
    301103: "This candidate status was invalided",
    301104: "IncreaseStake von is too low",
    301105: "Delegate deposit too low",
    301106: "The account is not allowed to be used for delegating",
    301107: "This candidate is not allow to delegate",
    301108: "Withdrew delegate von is too low",
    301109: "This is delegate is not exist",
    301110: "The von operationType is wrong",
    301111: "The von of account is not enough",
    301112: "The von of account is not enough",
    301113: "The von of account is not enough",
    301114: "Withdrew delegate von calculate is wrong",
    301115: "The validator is not exist",
    301116: "The validator is not exist",
    301117: "The slash type is wrong",
    301118: "Slash amount is too large",
    301119: "Slash candidate von calculate is wrong",
    301200: "Getting verifierList is failed",
    301201: "Getting validatorList is failed",
    301202: "Getting candidateList is failed",
    301203: "Getting related of delegate is failed",
    301204: "Getting related of delegate is failed",
    301205: "Query delegate info failed",
    
    302001: "current active version not found",
    302002: "vote option error",
    302003: "proposal type error",
    302004: "proposal ID is empty",
    302005: "proposal ID already exists",
    302006: "proposal not found",
    302007: "PIPID is empty",
    302008: "PIPID already exists",
    302009: "endVotingRounds too small",
    302010: "endVotingRounds too large",
    302011: "newVersion should larger than current active version",
    302012: "another version proposal at voting stage",
    302013: "another version proposal at pre-active stage",
    302014: "another cancel proposal at voting stage",
    302015: "to be canceled proposal not found",
    302016: "to be canceled proposal not version type",
    302017: "to be canceled proposal not at voting stage",
    302018: "proposer is empty",
    302019: "verifier detail info not found",
    302020: "verifier status is invalid",
    302021: "Tx caller differ from staking",
    302022: "Tx caller is not verifier",
    302023: "Tx caller is not candidate",
    302024: "version sign error",
    302025: "verifier not upgraded",
    302026: "proposal not at voting stage",
    302027: "vote duplicated",
    302028: "declared version error",
    302029: "notify staking declared version error",
    302030: "tally result not found",
    
    303000: "duplicate signature verification failed",
    303001: "punishment has been implemented",
    303002: "blockNumber too high",
    303003: "evidence interval is too long",
    303004: "failed to get certifier information",
    303005: "address does not match",
    303006: "nodeId does not match",
    303007: "blsPubKey does not match",
    303008: "slashing node fail",
    
    304001: "param epoch can't be zero",
    304002: "the number of the restricting plan can't be zero or more than 36",
    304003: "total restricting amount need more than 1 LAT",
    304004: "the balance is not enough in restrict",
    304005: "account is not found on restricting contract",
    304006: "slashing amount is larger than staking amount",
    304007: "staking amount is 0",
    304008: "Amount can't less than 0",
    304009: "staking return amount is wrong",
]
