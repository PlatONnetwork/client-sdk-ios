//
//  FuncType.swift
//  platonWeb3Demo
//
//  Created by Admin on 4/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation

enum FuncType {
    case createStaking(typ: UInt16, benifitAddress: String, nodeId: String, externalId: String, nodeName: String, website: String, details: String, amount: BigUInt)
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
    case submitText(verifier: String, githubID: String, topic: String, desc: String, url: String, endVotingBlock: UInt64)
    case submitVersion(verifier: String, githubID: String, topic: String, desc: String, url: String, newVersion: UInt, endVotingBlock: UInt64, activeBlock: UInt64)
    case submitParam(verifier: String, githubID: String, topic: String, desc: String, url: String, endVotingBlock: UInt64, paramName: String, currentValue: String, newValue: String)
    case voteProposal(verifier: String, proposalID: String, option: VoteOption)
    case declareVersion(activeNode: String, version: UInt32)
    case proposal(proposalID: String)
    case proposalResult(proposalID: String)
    case proposalList
    case activeVersion
    case programVersion
    case listParam
    case reportMultiSign(data: String)
    case checkMultiSign(typ: UInt32, addr: String, blockNumber: UInt64)
    case createRestrictingPlan(account: String, plans: [RestrictingPlan])
    case restrictingInfo(account: String)
}

extension FuncType {
    var typeValue: UInt16 {
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
        case .programVersion:
            return 2104
        case .listParam:
            return 2105
        case .reportMultiSign:
            return 3000
        case .checkMultiSign:
            return 3001
        case .createRestrictingPlan:
            return 4000
        case .restrictingInfo:
            return 4100
        }
    }
    
    var gas: BigUInt {
        switch self {
        case .createStaking:
            return PlatonConfig.FuncGas.createStakingGas
        case .editorStaking:
            return PlatonConfig.FuncGas.editorStakingGas
        case .increaseStaking:
            return PlatonConfig.FuncGas.increaseStakingGas
        case .withdrewStaking:
            return PlatonConfig.FuncGas.withdrewStakingGas
        case .createDelegate:
            return PlatonConfig.FuncGas.createDelegateGas
        case .withdrewDelegate:
            return PlatonConfig.FuncGas.withdrewDelegateGas
        case .submitText:
            return PlatonConfig.FuncGas.submitTextGas
        case .submitVersion:
            return PlatonConfig.FuncGas.submitVersionGas
        case .submitParam:
            return PlatonConfig.FuncGas.submitParamGas
        case .voteProposal:
            return PlatonConfig.FuncGas.voteProposalGas
        case .declareVersion:
            return PlatonConfig.FuncGas.declareVersionGas
        case .reportMultiSign:
            return PlatonConfig.FuncGas.reportMultiSignGas
        case .createRestrictingPlan:
            return PlatonConfig.FuncGas.createRestrictingPlanGas
        default:
            return PlatonConfig.FuncGas.defaultGas
        }
    }
    
    var gasPrice: BigUInt {
        return PlatonConfig.FuncGasPrice.defaultGasPrice
    }
    
    
    var rlpData: Data {
        switch self {
        case .createStaking(let typ, let benifitAddress, let nodeId, let externalId, let nodeName, let website, let details, let amount):
            let data = build_createStaking(typ: typ, benifitAddress: benifitAddress, nodeId: nodeId, externalId: externalId, nodeName: nodeName, website: website, details: details, amount: amount)
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
        case .submitText(let verifier, let githubID, let topic, let desc, let url, let endVotingBlock):
            let data = build_submitText(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: endVotingBlock)
            return data
        case .submitVersion(let verifier, let githubID, let topic, let desc, let url, let newVersion, let endVotingBlock, let activeBlock):
            let data = build_submitVersion(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, newVersion: newVersion, endVotingBlock: endVotingBlock, activeBlock: activeBlock)
            return data
        case .submitParam(let verifier, let githubID, let topic, let desc, let url, let endVotingBlock, let paramName, let currentValue, let newValue):
            let data = build_submitParam(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: endVotingBlock, paramName: paramName, currentValue: currentValue, newValue: newValue)
            return data
        case .voteProposal(let verifier, let proposalID, let option):
            let data = build_vote(verifier: verifier, proposalID: proposalID, option: option)
            return data
        case .declareVersion(let activeNode, let version):
            let data = build_declareVersion(activeNode: activeNode, version: version)
            return data
        case .proposal(let proposalID):
            let data = build_proposal(proposalID: proposalID)
            return data
        case .proposalResult(let proposalID):
            let data = build_proposalResult(proposalID: proposalID)
            return data
        case .reportMultiSign(let data):
            let data = build_reportDoubleSign(data: data)
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
             .programVersion,
             .listParam:
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
    
    func build_reportDoubleSign(data: String) -> Data {
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
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
        let typData = Data.newData(uint32data: typ)
        let blockNumberData = Data.newData(unsignedLong: blockNumber)
        let ethAddress = EthereumAddress(hexString: addr)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typData.bytes),
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
    
    func build_submitText(verifier: String,
                          githubID: String,
                          topic: String,
                          desc: String,
                          url: String,
                          endVotingBlock: UInt64) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let endVotingBlockData = Data.newData(unsignedLong: endVotingBlock)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(githubID.bytes),
            RLPItem.bytes(topic.bytes),
            RLPItem.bytes(desc.bytes),
            RLPItem.bytes(url.bytes),
            RLPItem.bytes(endVotingBlockData.bytes.trimLeadingZeros()),
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
                             githubID: String,
                             topic: String,
                             desc: String,
                             url: String,
                             newVersion: UInt,
                             endVotingBlock: UInt64,
                             activeBlock: UInt64) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let newVersionData = newVersion.makeBytes()
        let endVotingBlockData = Data.newData(unsignedLong: endVotingBlock)
        let activeBlockData = Data.newData(unsignedLong: endVotingBlock)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(githubID.bytes),
            RLPItem.bytes(topic.bytes),
            RLPItem.bytes(desc.bytes),
            RLPItem.bytes(url.bytes),
            RLPItem.bytes(newVersionData.trimLeadingZeros()),
            RLPItem.bytes(endVotingBlockData.bytes.trimLeadingZeros()),
            RLPItem.bytes(activeBlockData.bytes.trimLeadingZeros())
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
                           githubID: String,
                           topic: String,
                           desc: String,
                           url: String,
                           endVotingBlock: UInt64,
                           paramName: String,
                           currentValue: String,
                           newValue: String) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let endVotingBlockData = Data.newData(unsignedLong: endVotingBlock)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(githubID.bytes),
            RLPItem.bytes(topic.bytes),
            RLPItem.bytes(desc.bytes),
            RLPItem.bytes(url.bytes),
            RLPItem.bytes(endVotingBlockData.bytes.trimLeadingZeros()),
            RLPItem.bytes(paramName.bytes),
            RLPItem.bytes(currentValue.bytes),
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
                    option: VoteOption) -> Data {
        let verifierBytes = try? verifier.hexBytes()
        let proposalBytes = try? proposalID.hexBytes()
        let progressVersion = Data.newData(uint32data: PlatonConfig.ContractVersion.programVersion)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(verifierBytes!),
            RLPItem.bytes(proposalBytes!),
            RLPItem.bytes(option.rawValue.makeBytes()),
            RLPItem.bytes(progressVersion.bytes.trimLeadingZeros())
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
                              version: UInt32) -> Data {
        let activeNodeBytes = try? activeNode.hexBytes()
        let versionData = Data.newData(uint32data: version)
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(activeNodeBytes!),
            RLPItem.bytes(versionData.bytes.trimLeadingZeros()),
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
        let typData = Data.newData(uInt16Data: typ)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typData.bytes),
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
        let typData = Data.newData(uInt16Data: typ)
        let nodeIdBytes = try? nodeId.hexBytes()
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bytes(typData.bytes),
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
                             amount: BigUInt) -> Data {
        let typData = Data.newData(uInt16Data: typ)
        let ethAddress = EthereumAddress(hexString: benifitAddress)
        let nodeIdBytes = try? nodeId.hexBytes()
        let progressVersion = Data.newData(uint32data: PlatonConfig.ContractVersion.programVersion)
        
        let rlpItemss = [
            RLPItem.bytes(typeValue.makeBytes()),
            RLPItem.bytes(typData.bytes),
            RLPItem.bytes(ethAddress!.rawAddress),
            RLPItem.bytes(nodeIdBytes!),
            RLPItem.bytes(externalId.bytes),
            RLPItem.bytes(nodeName.bytes),
            RLPItem.bytes(website.bytes),
            RLPItem.bytes(details.bytes),
            RLPItem.bigUInt(amount),
            RLPItem.bytes(progressVersion.bytes.trimLeadingZeros())
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

//enum FuncType: UInt16 {
//    case createStaking = 1000
//    case editorStaking
//    case increaseStaking
//    case withdrewStaking
//    case createDelegate
//    case withdrewDelegate
//    case verifierList = 1100
//    case validatorList
//    case candidateList
//    case delegateListByAddr
//    case delegateInfo
//    case stakingInfo
//    case submitText = 2000
//    case submitVersion
//    case submitParam
//    case voteProposal
//    case declareVersion
//    case proposal = 2100
//    case proposalResult
//    case proposalList
//    case activeVersion
//    case programVersion
//    case listParam
//    case reportMultiSign = 3000
//    case checkMultiSign
//    case createRestrictingPlan = 4000
//    case restrictingInfo = 4100
//}
//
//enum FuncRLPData {
//    case createStaking()
//}
//
//extension FuncType {
//    var rlpData: Data {
//        switch self {
//        case .createStaking():
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
//}
//
//extension FuncType {
//
//    }
//}
