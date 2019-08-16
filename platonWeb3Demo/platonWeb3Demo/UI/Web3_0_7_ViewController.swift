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
    
    let web3j: Web3 = Web3(rpcURL: "http://10.10.8.200:6789")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
    }
    
    func testForCreateStaking() {
        let typ = UInt16(1)
        let bAddress = "0x5e57ae97e714abe990c882377aaf9c57f4ea363b"
        let nodeId = "7dd1e2474a49aa19cd2ef7f806f28d97595674723fc73c38602df12c758126e9eee4e25d44d700ea06aad0eacf3990d7f8f7a4f41350eebbf644cc406305943c"
        let externalId = "liyf-test-id"
        let nodeName = "liyf-test"
        let website = "www.baidu.com"
        let details = "details"
        let amount = BigUInt("1000000000000000000000000000")
        
        web3j.staking.createStaking(
            typ: typ,
            benifitAddress: bAddress,
            nodeId: nodeId,
            externalId: externalId,
            nodeName: nodeName,
            website: website,
            details: details,
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
        let typ = UInt16(1)
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let amount = BigUInt("1000000000000000000000000")
        
        web3j.staking.createDelegate(
            typ: typ,
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
        let bAddress = "0x12c171900f010b17e969702efa044d077e868082"
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
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
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
        let nodeId = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
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
        
        web3j.proposal.submitText(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: block,
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
    
    func testForSubmitVersion() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let githubID = "GithubID"
        let topic = "Topic"
        let desc = "Desc"
        let url = "http://www.test.inet"
        let newVersion = UInt(1)
        let eblock = UInt64(1000)
        let ablock = UInt64(1000)
        
        web3j.proposal.submitVersion(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, newVersion: newVersion, endVotingBlock: eblock, activeBlock: ablock,
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
    
    func testForSubmitParam() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let githubID = "GithubID"
        let topic = "Topic"
        let desc = "Desc"
        let url = "http://www.test.inet"
        let eblock = UInt64(1000)
        let paramName = "ParamName"
        let currentValue = "0.85"
        let newValue = "1.02"
        let ablock = UInt64(1000)
        
        web3j.proposal.submitParam(verifier: verifier, githubID: githubID, topic: topic, desc: desc, url: url, endVotingBlock: eblock, paramName: paramName, currentValue: currentValue, newValue: newValue,
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
    
    func testForVote() {
        
        let verifier = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let proposalID = "0x12c171900f010b17e969702efa044d077e86808212c171900f010b17e969702e"
        let option = VoteOption.Yeas
        
        web3j.proposal.vote(verifier: verifier, proposalID: proposalID, option: option,
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
    
    func testDeclareVersion() {
        
        let nodeName = "1f3a8672348ff6b789e416762ad53e69063138b8eb4d8780101658f24b2369f1a8e09499226b467d8bc0c4e03e1dc903df857eeb3c67733d21b6aaee2840e429"
        let version = UInt32(1)
        
        web3j.proposal.declareVersion(activeNode: nodeName, version: version,
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
        web3j.proposal.getProgramVersion(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForlistParam() {
        web3j.proposal.getListParam(sender: sender) { (result, data) in
            switch result {
            case .success:
                print(data)
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForReportDuplicateSign() {
        
        let data = "0x12c171900f010b17e969702efa044d077e868082"
        web3j.slash.reportDoubleSign(data: data,
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
    
    func testForCheckDuplicateSign() {
        
        let typ = UInt32(1)
        let addr = "0x12c171900f010b17e969702efa044d077e868082"
        let blockNumber = UInt64(1000)
        web3j.slash.checkDoubleSign(sender: sender, typ: typ, addr: addr, blockNumber: blockNumber) { (result, data) in
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
        case 22:
            testForlistParam()
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
