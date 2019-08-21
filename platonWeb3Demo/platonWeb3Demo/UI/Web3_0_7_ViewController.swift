//
//  Web3_0_7_ViewController.swift
//  platonWeb3Demo
//
//  Created by Admin on 25/7/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit
import BigInt

class Web3_0_7_ViewController: BaseTableViewController {

    var firstdemoContract = firstdemo()
    
    let web3j: Web3 = Web3(rpcURL: "http://192.168.120.76:6796")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
    }
    
    func testToHex(tmpid: Int) -> String {
        let leftInt: Int = tmpid/16
        let rightInt: Int = tmpid%16
        var leftIndex: String = ""
        var rightIndex: String = ""
        let numberArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F"]
        for i in 0..<numberArray.count {
            if i == leftInt {
                leftIndex = numberArray[i]
            }
            if i == rightInt {
                rightIndex = numberArray[i]
            }
        }
        return "\(leftIndex)\(rightIndex)"
    }
    
    func testForCreateStaking() {
        
        let content = String(hexString: "0x849b8477b22537461747573223a66616c73652c2244617461223a22222c224572724d7367223a225468652070726f6772616d2076657273696f6e207369676e2069732077726f6e67227d")
//        let hexString = "849b8477b22537461747573223a66616c73652c2244617461223a22222c224572724d7367223a225468652070726f6772616d2076657273696f6e207369676e2069732077726f6e67227d"
        print(content)
        return
        let typ = UInt16(0)
        let bAddress = "0x48c867ddBF22062704D6c81d3FA256bc6fc8b6bC"
        let nodeId = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        let externalId = "liyf-test-id"
        let nodeName = "liyf-test"
        let website = "www.baidu.com"
        let details = "details"
        let amount = BigUInt("100000000000000000000000")
        let blsPubKey = "7f58e6c152917637069be6b3fab9ebe9d3e5c9f5cf7dbf34e95c89647b2c7001e01447b8e2f697bff8f963e44cf7ca15a183ff1c0e701089ee2cd381f217e112"
        
        web3j.staking.createStaking(
            typ: typ,
            benifitAddress: bAddress,
            nodeId: nodeId,
            externalId: externalId,
            nodeName: nodeName,
            website: website,
            details: details,
            amount: amount,
            blsPubKey: blsPubKey,
            sender: sender,
            privateKey: privateKey) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForEditorStaking() {
        let bAddress = "0x12c171900f010b17e969702efa044d077e868082"
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let externalId = "111111"
        let nodeName = "platon"
        let website = "https://www.test.network"
        let details = "supper node"
        
        web3j.staking.editorStaking(
            benifitAddress: bAddress,
            nodeId: nodeId,
            externalId: externalId,
            nodeName: nodeName,
            website: website,
            details: details,
            sender: sender,
            privateKey: privateKey) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForIncreseStaking() {
        let typ = UInt16(1)
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let amount = BigUInt("1000000000000000000000000")
        
        web3j.staking.increseStaking(
            nodeId: nodeId,
            typ: typ,
            amount: amount,
            sender: sender,
            privateKey: privateKey) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForWithdrewStaking() {
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        
        web3j.staking.withdrewStaking(nodeId: nodeId,
                                      sender: sender,
                                      privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForDelegate() {
        let typ = UInt16(0)
//        let typ = UInt16(bytes: [0x00,0x00])
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        let amount = BigUInt("100000000000000000000000")!
        let privateKey1 = "0x9614c2b32f2d5d3421591ab3ffc03ac66c831fb6807b532f6e3a8e7aac31f1d9"
        let sender1 = "0xceca295e1471b3008d20b017c7df7d4f338a7fba"
        
        web3j.staking.createDelegate(
            typ: typ,
            nodeId: nodeId,
            amount: amount,
            sender: sender1,
            privateKey: privateKey1) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForWithDrawDelegate() {
        let stakingBlockNum = UInt64(1000)
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let amount = BigUInt("1000000000000000000000000")
        
        web3j.staking.withdrewDelegate(
            stakingBlockNum: stakingBlockNum,
            nodeId: nodeId,
            amount: amount,
            sender: sender,
            privateKey: privateKey) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForGetVerifierList() {
        web3j.staking.getVerifierList(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetValidatorList() {
        web3j.staking.getValidatorList(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetCandidateList() {
        web3j.staking.getCandidateList(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetRelatedListByDelAddr() {
        let bAddress = "0xeD04525c1240D19bc5a05787D96A903022eABDDf"
        web3j.staking.getDelegateListByDelAddr(sender: sender, addr: bAddress) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetDelegateInfo() {
        let stakingBlockNum = UInt64(1000)
        let bAddress = "0x12c171900f010b17e969702efa044d077e868082"
        let nodeId = "3aca21c898c892dae5081682119573c86b4dec3d50875cd95358cc28068231929827f3ee95471cb857986ad7f4b7d64f54be493dc3d476f603bdc2bc8a64e79b"
        web3j.staking.getDelegateInfo(sender: sender, stakingBlockNum: stakingBlockNum, delAddr: bAddress, nodeId: nodeId) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetCandidateInfo() {
        let nodeId = "3aca21c898c892dae5081682119573c86b4dec3d50875cd95358cc28068231929827f3ee95471cb857986ad7f4b7d64f54be493dc3d476f603bdc2bc8a64e79b"
        web3j.staking.getStakingInfo(sender: sender, nodeId: nodeId) { (result, data) in
            switch result {
            case .success:
                print(data)
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitText() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let githubID = "GithubID"
        let topic = "Topic"
        let desc = "Desc"
        let url = "http://www.test.inet"
        let block = UInt64(1000)
        
        web3j.proposal.submitText(verifier: verifier, pIDID: url, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitVersion() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let githubID = "GithubID"
        let topic = "Topic"
        let desc = "Desc"
        let url = "http://www.test.inet"
        let newVersion = UInt32(1)
        let eblock = UInt64(1000)
        let ablock = UInt64(1000)
        
        web3j.proposal.submitVersion(verifier: verifier, pIDID: url, newVersion: newVersion, endVotingBlock: eblock, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitParam() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let githubID = "GithubID"
        let topic = "Topic"
        let desc = "Desc"
        let url = "http://www.test.inet"
        let eblock = UInt64(1000)
        let paramName = "ParamName"
        let tobeCanceledProposalID = "0.85"
        let newValue = "1.02"
        let ablock = UInt64(1000)
        let newVersion = UInt32(1)
        
        web3j.proposal.submitCancel(verifier: verifier, pIDID: url, newVersion: newVersion, endVotingRounds: eblock, tobeCanceledProposalID: tobeCanceledProposalID, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForVote() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let proposalID = "0x12c171900f010b17e969702efa044d077e86808212c171900f010b17e969702e"
        let option = VoteOption.Yeas
        
        web3j.proposal.vote(verifier: verifier, proposalID: proposalID, option: option, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testDeclareVersion() {
        
        let nodeName = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let version = UInt32(1)
        let verifier = ""
        
        web3j.proposal.declareVersion(verifier: verifier, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetProposal() {
        let proid = "0x12c171900f010b17e969702efa044d077e86808212c171900f010b17e969702e"
        web3j.proposal.getProposal(sender: sender, proposalID: proid) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetTallyResult() {
        let proid = "0x12c171900f010b17e969702efa044d077e86808212c171900f010b17e969702e"
        web3j.proposal.getProposalResult(sender: sender, proposalID: proid) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForlistProposal() {
        web3j.proposal.getProposalList(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetActiveVersion() {
        web3j.proposal.getActiveVersion(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetProgramVersion() {
        web3j.staking.platonGetProgramVersion(sender: sender) { (result, data) in
            switch result {
            case .success:
                if let string = data as? String {
                    print(string)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForReportDuplicateSign() {
        
        let data = "0x12c171900f010b17e969702efa044d077e868082"
        web3j.slash.reportDuplicateSign(data: data, sender: sender, privateKey: privateKey) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForCheckDuplicateSign() {
        
        let typ = UInt32(1)
        let addr = "0x12c171900f010b17e969702efa044d077e868082"
        let blockNumber = UInt64(1000)
        web3j.slash.checkDuplicateSign(sender: sender, typ: typ, addr: addr, blockNumber: blockNumber) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForCreateRestrictingPlan() {
        let account = "0x12c171900f010b17e969702efa044d077e868082"
        let plans = [
            RestrictingPlan(epoch: UInt64(5), amount: BigUInt("1000000000000000000000000")),
            RestrictingPlan(epoch: UInt64(6), amount: BigUInt("2000000000000000000000000"))
        ]
        
        
        web3j.restricting.createRestrictingPlan(
            account: account,
            plans: plans,
            sender: sender,
            privateKey: privateKey) { (result, data) in
                switch result {
                case .success:
                    if let data = data as? Data {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForGetRestrictingInfo() {
        let account = "0x12c171900f010b17e969702efa044d077e868082"
        web3j.restricting.getRestrictingPlanInfo(sender: sender, account: account) { (result, data) in
            switch result {
            case .success:
                if let data = data as? Data {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testTransfer() {
//        let address = "0x..".data(using: .utf8)
//        let amout = Data(bytes: [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x02])
//        let gasPrice = BigUInt("22000000000")!
//        let gas = BigUInt("4300000")!
//        let sender = "0x60ceca9c1290ee56b98d4e160ef0453f7c40d219"
//        let privateKey = "4484092b68df58d639f11d59738983e2b8b81824f3c0c759edd6773f9adadfe7"
//        let contractAddress = "0x43355c787c50b647c425f594b441d4bd751951c1"
//        web3.platon.platonSendRawTransaction(code: ExecuteCode.ContractExecute,contractAddress: contractAddress, functionName: "transfer", params: [address!, amout], sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas,value: nil, estimated: false, completion: { (result, data) in
//            switch result{
//            case .success:
//                do{}
//            case .fail(_,_):
//                do{}
//            }
//        })
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            testForCreateStaking()
        case 1:
            testForEditorStaking()
        case 2:
            testForIncreseStaking()
        case 3:
            testForWithdrewStaking()
        case 4:
            testForDelegate()
        case 5:
            testForWithDrawDelegate()
        case 6:
            testForGetVerifierList()
        case 7:
            testForGetValidatorList()
        case 8:
            testForGetCandidateList()
        case 9:
            testForGetRelatedListByDelAddr()
        case 10:
            testForGetDelegateInfo()
        case 11:
            testForGetCandidateInfo()
        case 12:
            testForSubmitText()
        case 13:
            testForSubmitVersion()
        case 14:
            testForSubmitParam()
        case 15:
            testForVote()
        case 16:
            testDeclareVersion()
        case 17:
            testForGetProposal()
        case 18:
            testForGetTallyResult()
        case 19:
            testForlistProposal()
        case 20:
            testForGetActiveVersion()
        case 21:
            testForGetProgramVersion()
        case 23:
            testForReportDuplicateSign()
        case 24:
            testForCheckDuplicateSign()
        case 25:
            testForCreateRestrictingPlan()
        case 26:
            testForGetRestrictingInfo()
            
        default:
            do{}
        }
    }

}
