//
//  FuncType.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

public enum FuncType {
    case createStaking(typ: UInt16, benifitAddress: String, nodeId: String, externalId: String, nodeName: String, website: String, details: String, amount: BigUInt, programVersion: UInt32, programVersionSign: String, blsPubKey: String, blsProof: String)
    case editorStaking(benifitAddress: String, nodeId: String, externalId: String, nodeName: String, website: String, details: String)
    case increaseStaking(nodeId: String, typ: UInt16, amount: BigUInt)
    case withdrewStaking(nodeId: String)
    case createDelegate(typ: UInt16, nodeId: String, amount: BigUInt)
    case withdrewDelegate(stakingBlockNum: UInt64, nodeId: String, amount: BigUInt)
    case verifierList
    case validatorList
    case candidateList
    case delegateListByAddr(addr: String)
    case delegateInfo(stakingBlockNum: UInt64, delAddr: String, nodeId: String)
    case stakingInfo(nodeId: String)
    case submitText(verifier: String, pIDID: String)
    case submitVersion(verifier: String, pIDID: String, newVersion: UInt32, endVotingBlock: UInt64)
    case submitParam(verifier: String, pIDID: String, module: String, name: String, newValue: String)
    case submitCancel(verifier: String, pIDID: String, endVotingRounds: UInt64, tobeCanceledProposalID: String)
    case voteProposal(verifier: String, proposalID: String, option: VoteOption, programVersion: UInt32, versionSign: String)
    case declareVersion(verifier: String, programVersion: UInt32, versionSign: String)
    case proposal(proposalID: String)
    case proposalResult(proposalID: String)
    case proposalList
    case activeVersion
    case getGovernParamValue(module: String, name: String)
    case getAccuVerifiersCount(proposalID: String, blockHash: String)
    case listGovernParam(module: String)
    case reportMultiSign(typ: UInt8, data: String)
    case checkMultiSign(typ: UInt32, addr: String, blockNumber: UInt64)
    case createRestrictingPlan(account: String, plans: [RestrictingPlan])
    case restrictingInfo(account: String)
    case packageReward // 查询当前结算周期的区块奖励
    case stakingReward // 查询当前结算周期的质押奖励
    case avgPackTime // 查询打包区块的平均时间
}

extension FuncType {
    public var typeValue: UInt16 {
        switch self {
        case .createStaking:
            return 1000
        case .editorStaking:
            return 1001
        case .increaseStaking:
            return 1002
        case .withdrewStaking:
            return 1003
        case .createDelegate:
            return 1004
        case .withdrewDelegate:
            return 1005
        case .verifierList:
            return 1100
        case .validatorList:
            return 1101
        case .candidateList:
            return 1102
        case .delegateListByAddr:
            return 1103
        case .delegateInfo:
            return 1104
        case .stakingInfo:
            return 1105
        case .submitText:
            return 2000
        case .submitVersion:
            return 2001
        case .submitParam:
            return 2002
        case .submitCancel:
            return 2005
        case .voteProposal:
            return 2003
        case .declareVersion:
            return 2004
        case .proposal:
            return 2100
        case .proposalResult:
            return 2101
        case .proposalList:
            return 2102
        case .activeVersion:
            return 2103
        case .getGovernParamValue:
            return 2104
        case .getAccuVerifiersCount:
            return 2105
        case .listGovernParam:
            return 2106
        case .reportMultiSign:
            return 3000
        case .checkMultiSign:
            return 3001
        case .createRestrictingPlan:
            return 4000
        case .restrictingInfo:
            return 4100
        case .packageReward:
            return 1200
        case .stakingReward:
            return 1201
        case .avgPackTime:
            return 1202
        }
    }
    
    public var gas: BigUInt {
        switch self {
        case .createStaking:
            return PlatonConfig.FuncGas.createStakingGas + rlpData.dataGasUsed()
        case .editorStaking:
            return PlatonConfig.FuncGas.editorStakingGas + rlpData.dataGasUsed()
        case .increaseStaking:
            return PlatonConfig.FuncGas.increaseStakingGas + rlpData.dataGasUsed()
        case .withdrewStaking:
            return PlatonConfig.FuncGas.withdrewStakingGas + rlpData.dataGasUsed()
        case .createDelegate:
            return PlatonConfig.FuncGas.createDelegateGas + rlpData.dataGasUsed()
        case .withdrewDelegate:
            return PlatonConfig.FuncGas.withdrewDelegateGas + rlpData.dataGasUsed()
        case .submitText:
            return PlatonConfig.FuncGas.submitTextGas + rlpData.dataGasUsed()
        case .submitVersion:
            return PlatonConfig.FuncGas.submitVersionGas + rlpData.dataGasUsed()
        case .submitParam:
            return PlatonConfig.FuncGas.submitParamGas + rlpData.dataGasUsed()
        case .submitCancel:
            return PlatonConfig.FuncGas.submitCancelGas + rlpData.dataGasUsed()
        case .voteProposal:
            return PlatonConfig.FuncGas.voteProposalGas + rlpData.dataGasUsed()
        case .declareVersion:
            return PlatonConfig.FuncGas.declareVersionGas + rlpData.dataGasUsed()
        case .reportMultiSign:
            return PlatonConfig.FuncGas.reportMultiSignGas + rlpData.dataGasUsed()
        case .createRestrictingPlan(_, let plans):
            return PlatonConfig.FuncGas.createRestrictingPlanGas + rlpData.dataGasUsed() + PlatonConfig.FuncGas.defaultGas.multiplied(by: BigUInt(plans.count))
        default:
            return PlatonConfig.FuncGas.defaultGas
        }
    }
    
    public var gasPrice: BigUInt? {
        switch self {
        case .submitText:
            return PlatonConfig.FuncGasPrice.submitTextGasPrice.multiplied(by: PlatonConfig.VON.GVON)
        case .submitVersion:
            return PlatonConfig.FuncGasPrice.submitVersionGasPrice.multiplied(by: PlatonConfig.VON.GVON)
        case .submitCancel:
            return PlatonConfig.FuncGasPrice.submitCancelGasPrice.multiplied(by: PlatonConfig.VON.GVON)
        case .submitParam:
            return PlatonConfig.FuncGasPrice.submitParamGasPrice.multiplied(by: PlatonConfig.VON.GVON)
        default:
            return nil
        }
    }
    
    public var rlpData: Data {
        switch self {
        case .createStaking(let typ, let benifitAddress, let nodeId, let externalId, let nodeName, let website, let details, let amount, let programVersion, let programVersionSign, let blsPubKey, let blsProof):
            let data = build_createStaking(typ: typ, benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details, amount: amount, programVersion: programVersion, programVersionSign: programVersionSign, blsPubKey: blsPubKey, blsProof: blsProof)
            return data
        case .editorStaking(let benifitAddress, let nodeId, let externalId, let nodeName, let website, let details):
            let data = build_editorStaking(benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details)
            return data
        case .increaseStaking(let nodeId, let typ, let amount):
            let data = build_increseStaking(nodeId: nodeId, typ: typ, amount: amount)
            return data
        case .withdrewStaking(let nodeId):
            let data = build_withdrewStaking(nodeId: nodeId)
            return data
        case .createDelegate(let typ, let nodeId, let amount):
            let data = build_createDelegate(typ: typ, nodeId: nodeId, amount: amount)
            return data
        case .withdrewDelegate(let stakingBlockNum, let nodeId, let amount):
            let data = build_withdrewDelegate(stakingBlockNum: stakingBlockNum, nodeId: nodeId, amount: amount)
            return data
        case .delegateListByAddr(let addr):
            let data = build_delegateListByAddr(addr: addr)
            return data
        case .delegateInfo(let stakingBlockNum, let delAddr, let nodeId):
            let data = build_delegateInfo(stakingBlockNum: stakingBlockNum, delAddr: delAddr, nodeId: nodeId)
            return data
        case .stakingInfo(let nodeId):
            let data = build_stakingInfo(nodeId: nodeId)
            return data
        case .submitText(let verifier, let pIDID):
            let data = build_submitText(verifier: verifier, pIDID: pIDID)
            return data
        case .submitVersion(let verifier, let pIDID, let newVersion, let endVotingBlock):
            let data = build_submitVersion(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingBlock: endVotingBlock)
            return data
        case .submitParam(let verifier, let pIDID, let module, let name, let newValue):
            let data = build_submitParam(verifier: verifier, pIDID: pIDID, module: module, name: name, newValue: newValue)
            return data
        case .submitCancel(let verifier, let pIDID, let endVotingRounds, let tobeCanceledProposalID):
            let data = build_submitCancel(verifier: verifier, pIDID: pIDID, endVotingRounds: endVotingRounds, tobeCanceledProposalID: tobeCanceledProposalID)
            return data
        case .voteProposal(let verifier, let proposalID, let option, let programVersion, let versionSign):
            let data = build_vote(verifier: verifier, proposalID: proposalID, option: option, programVersion: programVersion, versionSign: versionSign)
            return data
        case .declareVersion(let activeNode, let version, let versionSign):
            let data = build_declareVersion(activeNode: activeNode, version: version, versionSign: versionSign)
            return data
        case .proposal(let proposalID):
            let data = build_proposal(proposalID: proposalID)
            return data
        case .proposalResult(let proposalID):
            let data = build_proposalResult(proposalID: proposalID)
            return data
        case .getGovernParamValue(let module, let name):
            let data = build_getGovernParamValue(module: module, name: name)
            return data
        case .getAccuVerifiersCount(let proposalID, let blockHash):
            let data = build_getAccuVerifiersCount(proposalID: proposalID, blockHash: blockHash)
            return data
        case .listGovernParam(let module):
            let data = build_listGovernParam(module: module)
            return data
        case .reportMultiSign(let typ, let data):
            let data = build_reportDoubleSign(typ: typ, data: data)
            return data
        case .checkMultiSign(let typ, let addr, let blockNumber):
            let data = build_checkDoubleSign(typ: typ, addr: addr, blockNumber: blockNumber)
            return data
        case .createRestrictingPlan(let account, let plans):
            let data = build_createRestrictingPlan(account: account, plans: plans)
            return data
        case .restrictingInfo(let account):
            let data = build_restrictingPlanInfo(account: account)
            return data
        case .verifierList,
             .validatorList,
             .candidateList,
             .proposalList,
             .activeVersion,
             .packageReward,
             .stakingReward,
             .avgPackTime:
            let data = build_defaultData()
            return data
        }
    }
    
    func build_createRestrictingPlan(account: String,
                                     plans: [RestrictingPlan]) -> Data {
        
        let plansRLP = plans.map { (plan) -> RLPItem in
            return try! plan.rlp()
        }
        
        let acccountAddress = EthereumAddress(hexString: account)
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(acccountAddress!.rawAddress),
            RLPItem.array(plansRLP)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_restrictingPlanInfo(account: String) -> Data {
        let acccountAddress = EthereumAddress(hexString: account)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(acccountAddress!.rawAddress),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_reportDoubleSign(typ: UInt8, data: String) -> Data {
        let typString = String(typ)
        let typBytes = try? typString.hexBytes().trimLeadingZeros()

        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typBytes ?? Bytes()),//需去掉0，不然提交会失败
            RLPItem.bytes(data.bytes),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_checkDoubleSign(typ: UInt32,
                               addr: String,
                               blockNumber: UInt64) -> Data {
        let typString = String(typ)
        let typBytes = try? typString.hexBytes().trimLeadingZeros()
        
        let blockNumberData = Data.newData(unsignedLong: blockNumber)
        let ethAddress = EthereumAddress(hexString: addr)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typBytes ?? Bytes()),
            RLPItem.bytes(ethAddress!.rawAddress),
            RLPItem.bytes(blockNumberData.bytes.trimLeadingZeros()),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }

    func build_getGovernParamValue(
        module: String,
        name: String) -> Data {

        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(module.bytes),
            RLPItem.bytes(name.bytes)
        ]

        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }

        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)

        return Data(bytes: rawRlp!)
    }

    func build_getAccuVerifiersCount(
        proposalID: String,
        blockHash: String) -> Data {

        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(proposalID.hexToBytes()),
            RLPItem.bytes(blockHash.hexToBytes())
        ]

        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }

        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)

        return Data(bytes: rawRlp!)
    }

    func build_listGovernParam(
        module: String) -> Data {

        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(module.bytes)
        ]

        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }

        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)

        return Data(bytes: rawRlp!)
    }

    
    func build_submitText(verifier: String,
                          pIDID: String) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let pIDIDBytes = try? pIDID.hexBytes()
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(pIDIDBytes!)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_submitVersion(verifier: String,
                             pIDID: String,
                             newVersion: UInt32,
                             endVotingBlock: UInt64) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let newVersionData = newVersion.makeBytes()
        let endVotingBlockData = Data.newData(unsignedLong: endVotingBlock)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(pIDID.bytes),
            RLPItem.bytes(newVersionData.trimLeadingZeros()),
            RLPItem.bytes(endVotingBlockData.bytes.trimLeadingZeros())
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_submitCancel(
        verifier: String,
        pIDID: String,
        endVotingRounds: UInt64,
        tobeCanceledProposalID: String) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let endVotingBlockData = Data.newData(unsignedLong: endVotingRounds)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(pIDID.bytes),
            RLPItem.bytes(endVotingBlockData.bytes.trimLeadingZeros()),
            RLPItem.bytes(tobeCanceledProposalID.hexToBytes())
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_submitParam(verifier: String,
                           pIDID: String,
                           module: String,
                           name: String,
                           newValue: String) -> Data {
        let verifierBytes = try? verifier.hexBytes()

        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(pIDID.bytes),
            RLPItem.bytes(module.bytes),
            RLPItem.bytes(name.bytes),
            RLPItem.bytes(newValue.bytes)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_vote(verifier: String,
                    proposalID: String,
                    option: VoteOption,
                    programVersion: UInt32,
                    versionSign: String) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let proposalBytes = try? proposalID.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(proposalBytes!),
            RLPItem.bytes(option.rawValue.makeBytes()),
            RLPItem.bytes(programVersion.makeBytes().trimLeadingZeros()),
            RLPItem.bytes(versionSign.hexToBytes())
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_declareVersion(activeNode: String,
                              version: UInt32,
                              versionSign: String) -> Data {
        let activeNodeBytes = try? activeNode.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(activeNodeBytes!),
            RLPItem.bytes(version.makeBytes().trimLeadingZeros()),
            RLPItem.bytes(versionSign.hexToBytes())
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_proposal(proposalID: String) -> Data {
        let proposalIDBytes = try? proposalID.hexBytes()
        
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(proposalIDBytes!)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_proposalResult(proposalID: String) -> Data {
        let proposalIDBytes = try? proposalID.hexBytes()
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(proposalIDBytes!)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_delegateListByAddr(addr: String) -> Data {
        let ethAddress = EthereumAddress(hexString: addr)
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(ethAddress!.rawAddress),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_delegateInfo(stakingBlockNum: UInt64,
                            delAddr: String,
                            nodeId: String) -> Data {
        let blockNum = Data.newData(unsignedLong: stakingBlockNum)
        let ethAddress = EthereumAddress(hexString: delAddr)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(blockNum.bytes.trimLeadingZeros()),
            RLPItem.bytes(ethAddress!.rawAddress),
            RLPItem.bytes(nodeIdBytes!),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_stakingInfo(nodeId: String) -> Data {
        let nodeIdBytes = try? nodeId.hexBytes()
        
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(nodeIdBytes!),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_defaultData() -> Data {
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_withdrewDelegate(stakingBlockNum: UInt64,
                                nodeId: String,
                                amount: BigUInt) -> Data {
        let stakingBlockNumData = Data.newData(unsignedLong: stakingBlockNum)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(stakingBlockNumData.bytes.trimLeadingZeros()),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bigUInt(amount),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_createDelegate(typ: UInt16,
                              nodeId: String,
                              amount: BigUInt) -> Data {
        let nodeIdBytes = try? nodeId.hexBytes()
        let typString = String(typ)
        let typBytes = try? typString.hexBytes().trimLeadingZeros()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typBytes ?? Bytes()),//需去掉0，不然提交会失败
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bigUInt(amount),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_withdrewStaking(nodeId: String) -> Data {
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(nodeIdBytes!)
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_increseStaking(nodeId: String,
                              typ: UInt16,
                              amount: BigUInt) -> Data {
        let nodeIdBytes = try? nodeId.hexBytes()
        let typString = String(typ)
        let typBytes = try? typString.hexBytes().trimLeadingZeros()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bytes(typBytes ?? Bytes()),
            RLPItem.bigUInt(amount),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_editorStaking(benifitAddress: String,
                             nodeId: String,
                             externalId: String,
                             nodeName: String,
                             website: String,
                             details: String) -> Data {
        let ethAddress = EthereumAddress(hexString: benifitAddress)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(ethAddress!.rawAddress),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bytes(externalId.bytes),
            RLPItem.bytes(nodeName.bytes),
            RLPItem.bytes(website.bytes),
            RLPItem.bytes(details.bytes),
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
    
    func build_createStaking(typ: UInt16,
                             benifitAddress: String,
                             nodeId: String,
                             externalId: String,
                             nodeName: String,
                             website: String,
                             details: String,
                             amount: BigUInt,
                             programVersion: UInt32,
                             programVersionSign: String,
                             blsPubKey: String,
                             blsProof: String) -> Data {
        let typString = String(typ)
        let typBytes = try? typString.hexBytes().trimLeadingZeros()
        
        let ethAddress = EthereumAddress(hexString: benifitAddress)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typBytes ?? Bytes()),
            RLPItem.bytes(ethAddress!.rawAddress),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bytes(externalId.bytes),
            RLPItem.bytes(nodeName.bytes),
            RLPItem.bytes(website.bytes),
            RLPItem.bytes(details.bytes),
            RLPItem.bigUInt(amount),
            RLPItem.bytes(programVersion.makeBytes().trimLeadingZeros()),
            RLPItem.bytes(programVersionSign.hexToBytes()),
            RLPItem.bytes(blsPubKey.hexToBytes()),
            RLPItem.bytes(blsProof.hexToBytes())
        ]
        
        let rlpedItems = rlpItemss.map { (rlpItem) -> RLPItem in
            let rawRlp = try? RLPEncoder().encode(rlpItem)
            return RLPItem.bytes(rawRlp ?? Bytes())
        }
        
        let rlpItems = RLPItem.array(rlpedItems)
        let rawRlp = try? RLPEncoder().encode(rlpItems)
        
        return Data(bytes: rawRlp!)
    }
}
