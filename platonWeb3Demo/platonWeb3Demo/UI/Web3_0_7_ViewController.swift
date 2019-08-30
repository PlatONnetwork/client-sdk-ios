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
    
    let web3j: Web3 = Web3(rpcURL: "http://192.168.120.76:6794")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
    }
    
    func testForCreateStaking() {
        
//        let hash = "0x77f54a21c9c4961c00f7f37df7369128c6ad7054708231a8c96f6ff2ed4a9435"
//        web3j.platon.getTransactionReceipt(txHash: hash, loopTime: 1) { (result, data) in
//            print("get receipt =================")
//            print(result)
//            print(data)
//        }
//        return
        
        let typ = UInt16(0)
        let bAddress = "0x48c867ddBF22062704D6c81d3FA256bc6fc8b6bC"
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        let externalId = "liyf-test-id"
        let nodeName = "yujinghan-node"
        let website = "www.baidu.com"
        let details = "f**king stupid"
        let amount = BigUInt("5000000").multiplied(by: PlatonConfig.VON.LAT)
        let blsPubKey = "80d98a48400a36e3da9de8e227e4a8c8fa3f90c08c82a467c9ac01298c2eb57f543d7e9568b0f381cc6c9de911870d1292b62459d083700d3958d775fca60e41ddd7d8532163f5acabaa6e0c47b626c39de51d9d67fb97a5af1871a661ca7788"
        
        let address = try? EthereumAddress(hex: sender, eip55: false)
        web3j.platon.getBalance(address: address!, block: .latest) { (response) in
            print(response)
        }
        return
        
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
            privateKey: privateKey) { (result, response) in
                switch result {
                case .success:
                    if let data = response {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForEditorStaking() {
        let bAddress = "0x48c867ddBF22062704D6c81d3FA256bc6fc8b6bC"
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
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
            privateKey: privateKey) { (result, response) in
                switch result {
                case .success:
                    if let data = response {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForIncreseStaking() {
        let typ = UInt16(0)
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        let amount = BigUInt("1000000").multiplied(by: PlatonConfig.VON.LAT)
        
        web3j.staking.increseStaking(
            nodeId: nodeId,
            typ: typ,
            amount: amount,
            sender: sender,
            privateKey: privateKey) { (result, response) in
                switch result {
                case .success:
                    if let data = response {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForWithdrewStaking() {
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        
        web3j.staking.withdrewStaking(nodeId: nodeId,
                                      sender: sender,
                                      privateKey: privateKey) { (result, response) in
            switch result {
            case .success:
                if let data = response {
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
        let delSender = "0x48c867ddBF22062704D6c81d3FA256bc6fc8b6bC"
        let delPrivateKey = "96f1f76c45bc2dd9c0f84a11da4ec104ae95661871284a29413a454a70b15307"
        web3j.staking.createDelegate(
            typ: typ,
            nodeId: nodeId,
            amount: amount,
            sender: delSender,
            privateKey: delPrivateKey) { (result, response) in
                switch result {
                case .success:
                    if let data = response {
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
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        let amount = BigUInt("1000000000000000000000000")
        
        web3j.staking.withdrewDelegate(
            stakingBlockNum: stakingBlockNum,
            nodeId: nodeId,
            amount: amount,
            sender: sender,
            privateKey: privateKey) { (result, response) in
                switch result {
                case .success:
                    if let data = response {
                        let txHash = data.toHexString()
                        print(txHash)
                    }
                case .fail(_, _):
                    break
                }
        }
    }
    
    func testForGetVerifierList() {
        web3j.staking.getVerifierList(sender: sender) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetValidatorList() {
        web3j.staking.getValidatorList(sender: sender) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print("getValidatorList is right!!!!!!")
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetCandidateList() {
        web3j.staking.getCandidateList(sender: sender) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print("getCandidateList is right!!!!!!")
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetRelatedListByDelAddr() {
        web3j.staking.getDelegateListByDelAddr(sender: sender, addr: sender) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print("testForGetRelatedListByDelAddr is right!!!!!!")
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetDelegateInfo() {
        let stakingBlockNum = UInt64(636)
        let nodeId = "411a6c3640b6cd13799e7d4ed286c95104e3a31fbb05d7ae0004463db648f26e93f7f5848ee9795fb4bbb5f83985afd63f750dc4cf48f53b0e84d26d6834c20c"
        web3j.staking.getDelegateInfo(sender: sender, stakingBlockNum: stakingBlockNum, delAddr: sender, nodeId: nodeId) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print("GetDelegateInfo is right!!!!!")
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForGetCandidateInfo() {
        let nodeId = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        web3j.staking.getStakingInfo(sender: sender, nodeId: nodeId) { (result, response) in
            switch result {
            case .success:
                if let data = response?.result {
                    print("GetCandidateInfo is right!!!!!!!")
                    print(data)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitText() {
        
        let verifier = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        let pIDID = String("10")
        
        web3j.proposal.submitText(verifier: verifier, pIDID: pIDID, sender: sender, privateKey: privateKey) { (result, response) in
            switch result {
            case .success:
                if let data = response {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitVersion() {
        
        let verifier = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        let pIDID = "10"
        let newVersion = UInt32(1801)
        let eblock = UInt64(1)
        
        web3j.proposal.submitVersion(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingBlock: eblock, sender: sender, privateKey: privateKey) { (result, response) in
            switch result {
            case .success:
                if let data = response {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForSubmitCancel() {
        
        let verifier = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        let pIDID = "1234567890"
        let eblock = UInt64(1)
        let tobeCanceledProposalID = "ab83a48443fc5bcb662b9f91fef7c7baa0170c5d244a4c73f3054dadbb69a27d"
        let newVersion = UInt32(1)
        
        web3j.proposal.submitCancel(verifier: verifier, pIDID: pIDID, newVersion: newVersion, endVotingRounds: eblock, tobeCanceledProposalID: tobeCanceledProposalID, sender: sender, privateKey: privateKey) { (result, response) in
            switch result {
            case .success:
                if let data = response {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testForVote() {
        
        let verifier = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        let proposalID = "0x8292a10580b0497650293b3c0c27c5ebe89e1222bd4d2ee868b9b6326522816e"
        let option = VoteOption.Yeas
        
        web3j.proposal.vote(verifier: verifier, proposalID: proposalID, option: option, sender: sender, privateKey: privateKey) { (result, response) in
            switch result {
            case .success:
                if let data = response {
                    let txHash = data.toHexString()
                    print(txHash)
                }
            case .fail(_, _):
                break
            }
        }
    }
    
    func testDeclareVersion() {
        
        let verifier = "19f1c9aa5140bd1304a3260de640a521c33015da86b88cd2ecc83339b558a4d4afa4bd0555d3fa16ae43043aeb4fbd32c92b34de1af437811de51d966dc64365"
        
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
        let proid = "0x2ceea9176087f6fe64162b8efb2d71ffd0cc0c0326b24738bb644e71db0d5cc6"
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
        let proid = "0x2ceea9176087f6fe64162b8efb2d71ffd0cc0c0326b24738bb644e71db0d5cc6"
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
        
        let data = "{}"
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
        
        let typ = DuplicateSignType.prepare
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
        let account = "0xceca295e1471b3008d20b017c7df7d4f338a7fba"
        let plans = [
            RestrictingPlan(epoch: UInt64(100), amount: BigUInt("5000000000000000000")),
            RestrictingPlan(epoch: UInt64(200), amount: BigUInt("600000000000000000"))
        ]
        
        let sender1 = "0x8b239461d37e2f2002ded20e7950c241bc449d36"
        let pri1 = "9d8dc0c4895d3bc1df7e557dda91089b539fe681807dedcf458850b02d8e7790"
        web3j.restricting.createRestrictingPlan(
            account: account,
            plans: plans,
            sender: sender1,
            privateKey: pri1) { (result, data) in
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
        let account = "0xceca295e1471b3008d20b017c7df7d4f338a7fba"
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
            testForSubmitCancel()
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
