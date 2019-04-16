//
//  platonWeb3DemoTests.swift
//  platonWeb3DemoTests
//
//  Created by Admin on 16/4/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import XCTest
@testable import platonWeb3Demo

class platonWeb3DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func tgetABI() -> String?{
        let abiPath = Bundle.main.path(forResource: "assets/firstdemo.cpp.abi", ofType: "json")
        var abiS = try? String(contentsOfFile: abiPath!)
        abiS = abiS?.replacingOccurrences(of: "\r\n", with: "")
        abiS = abiS?.replacingOccurrences(of: "\n", with: "")
        abiS = abiS?.replacingOccurrences(of: " ", with: "")
        
        return abiS
    }
    
    func tgetBIN() -> Data?{
        let binPath = Bundle.main.path(forResource: "assets/firstdemo", ofType: "wasm")
        let bin = try? Data(contentsOf: URL(fileURLWithPath: binPath!))
        return bin
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let expection: XCTestExpectation = expectation(description: "async tesst")
        
        let t_web3 : Web3 = Web3(rpcURL: "https://syde.platon.network/test")
        t_web3.eth.getBalance(address: EthereumAddress(hexString: "0x493301712671Ada506ba6Ca7891F436D29185821")!, block: EthereumQuantityTag.latest) { (result) in
            print(result)
            expection.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    // 部署合约测试
    func testPlatonDeployContract() {
        let expection: XCTestExpectation = expectation(description: "deploy contract")
        let t_web3 : Web3 = Web3(rpcURL: "https://syde.platon.network/test")
        let t_sender = "0x493301712671Ada506ba6Ca7891F436D29185821"
        let t_privateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
        let t_gasPrice = BigUInt("1000000000")!
        let t_gas = BigUInt("240943980")!
        t_web3.eth.platonDeployContract(abi: self.tgetABI()!, bin: self.tgetBIN()!, sender: t_sender, privateKey: t_privateKey, gasPrice: t_gasPrice, gas: t_gas, estimateGas: false, waitForTransactionReceipt: true, timeout: 20, completion:{
            (result,hash,contractAddress,receipt) in
            switch result{
            case .success:
                XCTAssertNotNil(contractAddress)
                XCTAssertNotNil(hash)
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        })
        waitForExpectations(timeout: 30, handler: nil)
    }
    
    func testPlatonCall() {
        let t_web3 : Web3 = Web3(rpcURL: "https://syde.platon.network/test")
        let deployedContractAddress = "0x7b24f960805a4aa6b611bd8f2dc6fb410e1eb0cf"
        let paramter = SolidityFunctionParameter(name: "whateverkey", type: .string)
        let expection: XCTestExpectation = expectation(description: "platon call")
        
        t_web3.eth.platonCall(code: .ContractExecute, contractAddress: deployedContractAddress, functionName: "getName", from: nil, params: [], outputs: [paramter]) { (result, data) in
            switch result{
            case .success:
                XCTAssertNotNil(data, "platoncall返回数据为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    func testPlatonSendRawTransaction() {
        let expection: XCTestExpectation = expectation(description: "platon send raw transaction")
        
        let msg_s = SolidityWrappedValue.string("unitTestMessage")
        let msg_d = Data(hex: msg_s.value.abiEncode(dynamic: false)!)
        let t_web3 : Web3 = Web3(rpcURL: "https://syde.platon.network/test")
        let t_sender = "0x493301712671Ada506ba6Ca7891F436D29185821"
        let t_privateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
        let t_gasPrice = BigUInt("1000000000")!
        let t_gas = BigUInt("240943980")!
        let deployedContractAddress = "0x7b24f960805a4aa6b611bd8f2dc6fb410e1eb0cf"
        
        t_web3.eth.platonSendRawTransaction(code: .ContractExecute, contractAddress: deployedContractAddress, functionName: "invokeNotify", params: [msg_d], sender: t_sender, privateKey: t_privateKey, gasPrice: t_gasPrice, gas: t_gas, value: nil, estimated: false) { (result, data) in
            switch result{
            case .success:
                XCTAssertNotNil(data?.toHexString(), "send raw transaction 返回数据为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取交易详情
    func testPlatonGetTransactionReceipt() {
        let expection: XCTestExpectation = expectation(description: "PlatonGetTransactionReceipt")
        let t_web3 : Web3 = Web3(rpcURL: "https://syde.platon.network/test")
        let tInvokeNotifyHash = "08d87af3c84745253401ff18ae7efe65d9df7f0060f4603f09c4f74a1b51fd7f"
        t_web3.eth.platonGetTransactionReceipt(txHash: tInvokeNotifyHash, loopTime: 15) { (result, data) in
            switch result{
            case .success:
                XCTAssertNotNil(data!, "PlatonGetTransactionReceipt返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
//    //测试节点候选人申请质押
//    func testCandidateDeposit(){
//        let expection: XCTestExpectation = expectation(description: "CandidateDeposit")
//        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
//        let nodeId = "0x114e48f21d4d83ec9ac39a62062a804a0566742d80b191de5ba23a4dc25f7beda0e78dd169352a7ad3b11584d06a01a09ce047ad88de9bdcb63885e81de00a4d";//节点id
//        let owner = "0x493301712671ada506ba6ca7891f436d29185821"; //质押金退款地址
//        let fee = UInt64(500)
//        let host = "192.168.120.85"; //节点IP
//        let port = "16789"; //节点P2P端口号
//
//        var extra : Dictionary<String,String> = [:]
//        extra["nodeName"] = "xxxx-noedeName"
//        extra["nodePortrait"] = "http://192.168.120.85:16789/group2/M00/00/00/wKgJVlr0KDyAGSddAAYKKe2rswE261.png"
//        extra["nodeDiscription"] = "xxxx-nodeDiscription"
//        extra["nodeDepartment"] = "xxxx-nodeDepartment"
//        extra["officialWebsite"] = "https://www.platon.network/"
//
//        var theJSONText : String = ""
//        if let theJSONData = try? JSONSerialization.data(withJSONObject: extra,options: []) {
//            theJSONText = String(data: theJSONData,
//                                 encoding: .utf8)!
//        }
//
//        let tgasPrice = BigUInt("1000000000")!
//        let tgas = BigUInt("240943980")!
//
//        cContract.CandidateDeposit(nodeId: nodeId, owner: owner, fee: fee, host: host, port: port, extra: theJSONText, sender: sender, privateKey: privateKey, gasPrice: tgasPrice, gas: tgas, value: BigUInt("1000000000000000000")!) { (result, data) in
//            switch result{
//            case .success:
//                print("Transaction success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateDeposit empty transaction hash")
//                }
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
    
//    //测试节点押金退回申请
//    func testCandidateApplyWithdraw(){
//        let expection: XCTestExpectation = expectation(description: "SetCandidateExtra")
//        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
//        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";
//        //退款金额, 单位 wei
//        let value = BigUInt("500")!
//        //must be owner
//        let owner = "f8f3978c14f585c920718c27853e2380d6f5db36"
//        let ownerPrivateKey = "74df7c508a4e20a3da81b331e2168cff9e6bc085e1968a30a05daf85ae654ed6"
//        let t_gasPrice = BigUInt("1000000000")!
//        let t_gas = BigUInt("240943980")!
//
//        cContract.CandidateApplyWithdraw(nodeId: nodeId,withdraw: value,sender: owner,privateKey: ownerPrivateKey,gasPrice: t_gasPrice,gas: t_gas,value: BigUInt(1)) { (result, data) in
//            switch result{
//            case .success:
//                print("CandidateApplyWithdraw success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateApplyWithdraw empty transaction hash")
//                }
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
    
//    //测试节点质押金提取
//    func testCandidateWithdraw(){
//        let expection: XCTestExpectation = expectation(description: "CandidateWithdraw")
//        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
//        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";
//        cContract.CandidateWithdraw(nodeId: nodeId,sender: sender,privateKey: privateKey,gasPrice: gasPrice,gas: gas,value: BigUInt(0)) { (result, data) in
//            switch result{
//            case .success:
//                print("send Transaction success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateWithdraw empty transaction hash")
//                }
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
    
//    //测试节点附加信息
//    func testSetCandidateExtra() {
//        let expection: XCTestExpectation = expectation(description: "SetCandidateExtra")
//        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
//        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3"
//
//
//        var extra : Dictionary<String,String> = [:]
//        extra["nodeName"] = "xxxx-noedeName"
//        extra["nodePortrait"] = "group2/M00/00/12/wKgJVlw0XSyAY78cAAH3BKJzz9Y83.jpeg"
//        extra["nodeDiscription"] = "xxxx-nodeDiscription1"
//        extra["nodeDepartment"] = "xxxx-nodeDepartment"
//        extra["officialWebsite"] = "xxxx-officialWebsite"
//
//        var theJSONText : String = ""
//        if let theJSONData = try? JSONSerialization.data(withJSONObject: extra,options: []) {
//            theJSONText = String(data: theJSONData,
//                                 encoding: .utf8)!
//        }
//
//        //must be owner
//        let owner = "f8f3978c14f585c920718c27853e2380d6f5db36"
//        let ownerPrivateKey = "74df7c508a4e20a3da81b331e2168cff9e6bc085e1968a30a05daf85ae654ed6"
//        let gasPrice = BigUInt("1000000000")!
//        let gas = BigUInt("240943980")!
//
//        cContract.SetCandidateExtra(nodeId: nodeId, extra: theJSONText, sender: owner, privateKey: ownerPrivateKey, gasPrice: gasPrice, gas: gas, value: nil) { (result, data) in
//            switch result{
//            case .success:
//                print("send Transaction success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//
//                }else{
//                    print("SetCandidateExtra empty transaction hash")
//                }
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
    
    //测试获取所有入围节点的信息列表（验证 + 候选）
    func testGetCandidateList() {
        let expection: XCTestExpectation = expectation(description: "GetCandidateList")
        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        cContract.GetCandidateList { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "testGetCandidateList返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取参与当前共识的验证人列表
    func testGetVerifiersList() {
        let expection: XCTestExpectation = expectation(description: "GetVerifiersList")
        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        cContract.GetVerifiersList { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetVerifiersList返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取节点申请的退款记录列表
    func testGetCandidateWithdrawInfos() {
        let expection: XCTestExpectation = expectation(description: "GetCandidateWithdrawInfos")
        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        let nodeId = "0x3b53564afbc3aef1f6e0678171811f65a7caa27a927ddd036a46f817d075ef0a5198cd7f480829b53fe62bdb063bc6a17f800d2eebf7481b091225aabac2428d"
        
        cContract.GetCandidateWithdrawInfos(nodeId: nodeId) { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetCandidateDetails返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取候选人信息
    func testGetCandidateDetails() {
        let expection: XCTestExpectation = expectation(description: "GetCandidateDetails")
        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        let nodeId = "0x3b53564afbc3aef1f6e0678171811f65a7caa27a927ddd036a46f817d075ef0a5198cd7f480829b53fe62bdb063bc6a17f800d2eebf7481b091225aabac2428d"
        
        cContract.GetCandidateDetails(batchNodeIds: nodeId) { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetCandidateDetails返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    
    // 测试获取票的价格
    func testGetTicketPrice() {
        let expection: XCTestExpectation = expectation(description: "GetTicketPrice")
        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        tContract.GetTicketPrice { (result, data) in
            switch result {
            case .success:
                if let price = data as? String{
                    let text = "price is:\(price)"
                    print(text)
                }
                XCTAssertNotNil(data!, "GetTicketPrice返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试剩余票数量
    func testGetPoolRemainder() {
        let expection: XCTestExpectation = expectation(description: "GetPoolRemainder")
        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        tContract.GetPoolRemainder { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetPoolRemainder返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取候选人票龄
    func testGetCandidateEpoch() {
        let expection: XCTestExpectation = expectation(description: "GetCandidateEpoch")
        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        let candidateID = "0x3b53564afbc3aef1f6e0678171811f65a7caa27a927ddd036a46f817d075ef0a5198cd7f480829b53fe62bdb063bc6a17f800d2eebf7481b091225aabac2428d"
        
        tContract.GetCandidateEpoch(candidateId: candidateID) { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetCandidateEpoch返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    //测试获取指定候选人的有效选票数量
    func testGetTicketCountByTxHash() {
        let expection: XCTestExpectation = expectation(description: "GetTicketCountByTxHash")
        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        let ticketIds = ["0x02b7b41469782764fcbb2d9d4e9461e60ce3f92c098fce12dbffb07634934f74","0x33767704d735a180ef2ce2f18b03e3ae46141f4de71c7f842cf3069aafb4f20e"]
        
        tContract.GetTicketCountByTxHash(ticketIds: ticketIds) { (result, data) in
            switch result {
            case .success:
                XCTAssertNotNil(data!, "GetTicketCountByTxHash返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
    // 测试获取指定候选人的有效选票数量
    func testGetCandidateTicketCount() {
        let expection: XCTestExpectation = expectation(description: "GetCandidateTicketCount")
        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
        let nodeIds = ["0x858d6f6ae871e291d3b7b2b91f7369f46deb6334e9dacb66fa8ba6746ee1f025bd4c090b17d17e0d9d5c19fdf81eb8bde3d40a383c9eecbe7ebda9ca95a3fb94","0xe4556b211eb6712ab94d743990d995c0d3cd15e9d78ec0096bba24c48d34f9f79a52ca1f835cec589c5e7daff30620871ba37d6f5f722678af4b2554a24dd75c"]
        
        tContract.GetCandidateTicketCount(nodeIds: nodeIds) { (result, data) in
            switch result {
            case .success:
                if let tickets = data as? String{
                    print("GetCandidateTicketCount :" + tickets)
                }
                XCTAssertNotNil(data!, "GetCandidateTicketCount返回为空")
                expection.fulfill()
            case .fail(_, let errorMsg):
                XCTAssertNil(errorMsg, errorMsg!)
                expection.fulfill()
            }
        }
        wait(for: [expection], timeout: 10)
    }
    
//    // 测试给节点投票
//    func testVoteTicket() {
//        let expection: XCTestExpectation = expectation(description: "GetCandidateTicketCount")
//        let tContract = TicketContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
//        let price = BigUInt("100000000000000000000")!
//        let nodeId = "0x858d6f6ae871e291d3b7b2b91f7369f46deb6334e9dacb66fa8ba6746ee1f025bd4c090b17d17e0d9d5c19fdf81eb8bde3d40a383c9eecbe7ebda9ca95a3fb94"
//        let sender = "0x493301712671Ada506ba6Ca7891F436D29185821"
//        let privateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
//        let gasPrice = BigUInt("1000000000")!
//        let gas = BigUInt("240943980")!
//        tContract.VoteTicket(count: 2, price: price, nodeId: nodeId, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas) { (result, data) in
//            switch result{
//            case .success:
//                XCTAssertNotNil((data as? Data)!.toHexString(), "vote hash为空")
//                if let data = data as? Data{
//                    print("vote hash is is:\(data.toHexString())")
//                }
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
    

//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
