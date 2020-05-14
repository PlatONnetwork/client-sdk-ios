//
//  AddrCoder.swift
//
//  Created by Evolution Group Ltd on 12.02.2018.
//  Copyright © 2018 Evolution Group Ltd. All rights reserved.
//
//  Base32 address format for native v0-16 witness outputs implementation
//  https://github.com/bitcoin/bips/blob/master/bip-0173.mediawiki
//  Inspired by Pieter Wuille C++ implementation
//


import Foundation

/// Segregated Witness Address encoder/decoder
public class AddrCoder {
    public init() {}

    public static let shared = AddrCoder()
    private let bech32 = Bech32()

    /// Convert from one power-of-2 number base to another
    private func convertBits(from: Int, to: Int, pad: Bool, idata: Data) throws -> Data {
        var acc: Int = 0
        var bits: Int = 0
        let maxv: Int = (1 << to) - 1
        let maxAcc: Int = (1 << (from + to - 1)) - 1
        var odata = Data()
        for ibyte in idata {
            acc = ((acc << from) | Int(ibyte)) & maxAcc
            bits += from
            while bits >= to {
                bits -= to
                odata.append(UInt8((acc >> bits) & maxv))
            }
        }
        if pad {
            if bits != 0 {
                odata.append(UInt8((acc << (to - bits)) & maxv))
            }
        } else if (bits >= from || ((acc << (to - bits)) & maxv) != 0) {
            throw CoderError.bitsConversionFailed
        }
        return odata
    }

    /// Decode address
    public func decode(hrp: String? = nil, addr: String) throws -> Data {
        let dec = try bech32.decode(addr)
        if let hrp = hrp, dec.hrp != hrp {
            throw CoderError.hrpMismatch(dec.hrp, hrp)
        }
        guard dec.checksum.count >= 1 else {
            throw CoderError.checksumSizeTooLow
        }
        let conv = try convertBits(from: 5, to: 8, pad: false, idata: dec.checksum.advanced(by: 1))
        guard conv.count >= 2 && conv.count <= 40 else {
            throw CoderError.dataSizeMismatch(conv.count)
        }
        guard dec.checksum[0] <= 16 else {
            throw CoderError.versionNotSupported(dec.checksum[0])
        }
        if dec.checksum[0] == 0 && conv.count != 20 && conv.count != 32 {
            throw CoderError.programSizeMismatch(conv.count)
        }
        return conv
    }


    /// Decode address
    public func decodeHex(addr: String) throws -> String {
        let dec = try bech32.decode(addr)
        guard dec.checksum.count >= 1 else {
            throw CoderError.checksumSizeTooLow
        }
        let conv = try convertBits(from: 5, to: 8, pad: false, idata: dec.checksum)
        guard conv.count >= 2 && conv.count <= 40 else {
            throw CoderError.dataSizeMismatch(conv.count)
        }
        guard dec.checksum[0] <= 16 else {
            throw CoderError.versionNotSupported(dec.checksum[0])
        }
        if dec.checksum[0] == 0 && conv.count != 20 && conv.count != 32 {
            throw CoderError.programSizeMismatch(conv.count)
        }
        return "0x" + conv.toHexString()
    }


    /// Encode address
    public func encode(hrp: String, values: Data) throws -> String {
        let enc = try convertBits(from: 8, to: 5, pad: true, idata: values)
        let result = bech32.encode(hrp, values: enc)
        return result
    }

    /// Encode address
    public func encode(hrp: String, address: String) throws -> String {
//        return try addressEncode(hrp: hrp, values: Data(hex: address))
        let enc = try convertBits(from: 8, to: 5, pad: true, idata: Data(hex: address))
        let result = bech32.encode(hrp, values: enc)
        return result
    }
}

extension AddrCoder {
    public enum CoderError: LocalizedError {
        case bitsConversionFailed
        case hrpMismatch(String, String)
        case checksumSizeTooLow

        case dataSizeMismatch(Int)
        case versionNotSupported(UInt8)
        case programSizeMismatch(Int)

        case encodingCheckFailed

        public var errorDescription: String? {
            switch self {
            case .bitsConversionFailed:
                return "Failed to perform bits conversion"
            case .checksumSizeTooLow:
                return "Checksum size is too low"
            case .dataSizeMismatch(let size):
                return "Program size \(size) does not meet required range 2...40"
            case .encodingCheckFailed:
                return "Failed to check result after encoding"
            case .hrpMismatch(let got, let expected):
                return "Human-readable-part \"\(got)\" does not match requested \"\(expected)\""
            case .programSizeMismatch(let size):
                return "Program size \(size) does not meet version 0 requirments"
            case .versionNotSupported(let version):
                return "Version \(version) is not supported by this decoder"
            }
        }
    }
}
