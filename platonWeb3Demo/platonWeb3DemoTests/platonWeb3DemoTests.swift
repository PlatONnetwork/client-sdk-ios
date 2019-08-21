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
    
    var web3: Web3!
    var sender: String!
    var privateKey: String!
    var gasPrice: BigUInt!
    var gas: BigUInt!
    var deployedContractAddress: String!
    let nodeId = "0x11f00fd6ea74431c04d336428a5e95736673ee17547c1ccb58d3a64d7224bc7affac84a44b64500f7f35d3875be37078cfc95537a433c764e1921623718c8fdf";
    var senderAddress: EthereumAddress!
    
    let CandidateDepositExpection = XCTestExpectation(description: "CandidateDeposit")
    let CandidateApplyWithdrawExpection = XCTestExpectation(description: "CandidateApplyWithdraw")
    let CandidateWithdrawExpection = XCTestExpectation(description: "CandidateWithdraw")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        web3 = Web3(rpcURL: "http://10.10.8.21:6789")
        sender = "0x493301712671Ada506ba6Ca7891F436D29185821"
        privateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
        gasPrice = BigUInt("1000000000")!
        gas = BigUInt("240943980")!
        deployedContractAddress = "0x093acd8ff0b8ac2cd1491571142205474342e887"
        
        senderAddress = EthereumAddress(hexString: sender)
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


//    //测试获取交易详情
//    func testPlatonGetTransactionReceipt() {
//        let expection = XCTestExpectation(description: "PlatonGetTransactionReceipt")
//        let tInvokeNotifyHash = "442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8"
//        web3.eth.platonGetTransactionReceipt(txHash: tInvokeNotifyHash, loopTime: 15) { (result, data) in
//            switch result{
//            case .success:
//                XCTAssertNotNil(data!, "PlatonGetTransactionReceipt返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    //测试节点候选人申请质押\测试节点押金退回申请\测试节点质押金提取
//    func testCandidateDeposit(){
//        let owner = "0x493301712671Ada506ba6Ca7891F436D29185821"; //质押金退款地址
//        let fee = UInt64(500)
//        let host = "192.168.9.76"; //节点IP
//        let port = "16789"; //节点P2P端口号
//
//        var extra : Dictionary<String,String> = [:]
//        extra["nodeName"] = "xxxx-noedeName"
//        extra["nodePortrait"] = "http://192.168.9.76:16789/group2/M00/00/00/wKgJVlr0KDyAGSddAAYKKe2rswE261.png"
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
//        cContract.CandidateDeposit(nodeId: nodeId, owner: owner, fee: fee, host: host, port: port, extra: theJSONText, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: BigUInt("1000000000000000000")!) { (result, data) in
//            switch result{
//            case .success:
//                print("Transaction success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateDeposit empty transaction hash")
//                }
//                self.CandidateDepositExpection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                self.CandidateDepositExpection.fulfill()
//            }
//        }
//        let result1 = XCTWaiter.wait(for: [self.CandidateDepositExpection], timeout: 20)
//        XCTAssertEqual(result1, XCTWaiter.Result.completed)
//
//
//    }
//
//    func testCandidateApplyWithdraw() {
//        //退款金额, 单位 wei
//        let sender_1 = "0xc82bee7CD0AeAE05f098013bb976Cd5f4DF831AA"
//        let privateKey_1 = "6f0e1cbe07af716c96094dd5f5d18d875becdb7d5b9407ef196aeb31484ce2ee"
//        let value = BigUInt("500")!
//        cContract.CandidateApplyWithdraw(nodeId: nodeId,withdraw: value,sender: sender_1,privateKey: privateKey_1,gasPrice: gasPrice,gas: gas,value: BigUInt(0)) { (result, data) in
//            switch result{
//            case .success:
//                print("CandidateApplyWithdraw success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateApplyWithdraw empty transaction hash")
//                }
//                self.CandidateApplyWithdrawExpection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                self.CandidateApplyWithdrawExpection.fulfill()
//            }
//        }
//        let result2 = XCTWaiter.wait(for: [self.CandidateApplyWithdrawExpection], timeout: 20)
//        XCTAssertEqual(result2, XCTWaiter.Result.completed)
//
////        cContract.CandidateWithdraw(nodeId: nodeId,sender: sender,privateKey: privateKey,gasPrice: gasPrice,gas: gas,value: nil) { (result, data) in
////            switch result{
////            case .success:
////                print("send Transaction success")
////                if let data = data as? Data{
////                    print(data.toHexString())
////                }else{
////                    print("CandidateWithdraw empty transaction hash")
////                }
////                self.CandidateWithdrawExpection.fulfill()
////            case .fail(_, let errorMsg):
////                XCTAssertNil(errorMsg, errorMsg!)
////                self.CandidateWithdrawExpection.fulfill()
////            }
////        }
////        let result3 = XCTWaiter.wait(for: [self.CandidateWithdrawExpection], timeout: 20)
////        XCTAssertEqual(result3, XCTWaiter.Result.completed)
//    }
//
//    func testCandidateWithdraw() {
//        let sender_3 = "0xdC8B6Fa7B75f99580e59D5DF4600f1e2AF6a0078"
//        let privateKey_3 = "62f947e5df36b82bc828167617b6e5cb67003da7bc8e297aa5aa65bfea15325d"
//        cContract.CandidateWithdraw(nodeId: nodeId,sender: sender_3,privateKey: privateKey_3,gasPrice: gasPrice,gas: gas,value: nil) { (result, data) in
//            switch result{
//            case .success:
//                print("send Transaction success")
//                if let data = data as? Data{
//                    print(data.toHexString())
//                }else{
//                    print("CandidateWithdraw empty transaction hash")
//                }
//                self.CandidateWithdrawExpection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                self.CandidateWithdrawExpection.fulfill()
//            }
//        }
//        let result = XCTWaiter.wait(for: [CandidateWithdrawExpection], timeout: 20)
//        XCTAssertEqual(result, .completed)
//    }
//
//    //测试节点附加信息
//    func testSetCandidateExtra() {
//        let expection = expectation(description: "SetCandidateExtra")
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
//        let owner = "0x493301712671Ada506ba6Ca7891F436D29185821"
//        let ownerPrivateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
//        let gasPrice = BigUInt("1000000000")!
//        let gas = BigUInt("240943980")!
//
//        cContract.SetCandidateExtra(nodeId: nodeId, extra: theJSONText, sender: owner, privateKey: ownerPrivateKey, gasPrice: gasPrice, gas: gas, value: nil) { (result, data) in
//            switch result{
//            case .success:
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        let result1 = XCTWaiter.wait(for: [expection], timeout: 20)
//        XCTAssertEqual(result1, XCTWaiter.Result.completed)
//    }
//
//    func testGetCandidateDetails() {
//        let getCandidateDetailsExpection = expectation(description: "GetCandidateDetails")
//        cContract.GetCandidateDetails(batchNodeIds: nodeId) { (result, data1) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data1!, "GetCandidateDetails返回为空")
//                getCandidateDetailsExpection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                getCandidateDetailsExpection.fulfill()
//            }
//        }
//        let result2 = XCTWaiter.wait(for: [getCandidateDetailsExpection], timeout: 20)
//        XCTAssertEqual(result2, XCTWaiter.Result.completed)
//    }
//
//    //测试获取所有入围节点的信息列表（验证 + 候选）
//    func testGetCandidateList() {
//        let expection = expectation(description: "GetCandidateList")
//        cContract.GetCandidateList { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "testGetCandidateList返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    //测试获取参与当前共识的验证人列表
//    func testGetVerifiersList() {
//        let expection = expectation(description: "GetVerifiersList")
//        cContract.GetVerifiersList { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "GetVerifiersList返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    //测试获取节点申请的退款记录列表
//    func testGetCandidateWithdrawInfos() {
//        let expection = expectation(description: "GetCandidateWithdrawInfos")
//        let cContract = CandidateContract(web3: web3)
//        let nodeId = "0x3b53564afbc3aef1f6e0678171811f65a7caa27a927ddd036a46f817d075ef0a5198cd7f480829b53fe62bdb063bc6a17f800d2eebf7481b091225aabac2428d"
//
//        cContract.GetCandidateWithdrawInfos(nodeId: nodeId) { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "GetCandidateDetails返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
////    //测试获取候选人信息
////    func testGetCandidateDetails() {
////        let expection11 = XCTestExpectation(description: "GetCandidateDetails")
////        let cContract = CandidateContract(web3: Web3(rpcURL: "http://192.168.120.81:6789"))
////        let nodeId = "0x11f00fd6ea74431c04d336428a5e95736673ee17547c1ccb58d3a64d7224bc7affac84a44b64500f7f35d3875be37078cfc95537a433c764e1921623718c8fdf"
////
////        cContract.GetCandidateDetails(batchNodeIds: nodeId) { (result, data) in
////            switch result {
////            case .success:
////                XCTAssertNotNil(data!, "GetCandidateDetails返回为空")
////                expection11.fulfill()
////            case .fail(_, let errorMsg):
////                XCTAssertNil(errorMsg, errorMsg!)
////                expection11.fulfill()
////            }
////        }
////        wait(for: [expection11], timeout: 20)
////    }
//
//
//    // 测试获取票的价格
//    func testGetTicketPrice() {
//        let expection = expectation(description: "GetTicketPrice")
//        let tContract = TicketContract(web3: web3)
//        tContract.GetTicketPrice { (result, data) in
//            switch result {
//            case .success:
//                if let price = data as? String{
//                    let text = "price is:\(price)"
//                    print(text)
//                }
//                XCTAssertNotNil(data!, "GetTicketPrice返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 10)
//    }
//
//    //测试剩余票数量
//    func testGetPoolRemainder() {
//        let expection = expectation(description: "GetPoolRemainder")
//        let tContract = TicketContract(web3: web3)
//        tContract.GetPoolRemainder { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "GetPoolRemainder返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    //测试获取候选人票龄
//    func testGetCandidateEpoch() {
//        let expection = expectation(description: "GetCandidateEpoch")
//        let tContract = TicketContract(web3: web3)
//        let candidateID = "0x11f00fd6ea74431c04d336428a5e95736673ee17547c1ccb58d3a64d7224bc7affac84a44b64500f7f35d3875be37078cfc95537a433c764e1921623718c8fdf"
//
//        tContract.GetCandidateEpoch(candidateId: candidateID) { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "GetCandidateEpoch返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    //测试获取指定候选人的有效选票数量
//    func testGetTicketCountByTxHash() {
//        let expection = expectation(description: "GetTicketCountByTxHash")
//        let tContract = TicketContract(web3: web3)
//        let ticketIds = ["0x02b7b41469782764fcbb2d9d4e9461e60ce3f92c098fce12dbffb07634934f74","0x33767704d735a180ef2ce2f18b03e3ae46141f4de71c7f842cf3069aafb4f20e"]
//
//        tContract.GetTicketCountByTxHash(ticketIds: ticketIds) { (result, data) in
//            switch result {
//            case .success:
//                XCTAssertNotNil(data!, "GetTicketCountByTxHash返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
//
//    // 测试获取指定候选人的有效选票数量
//    func testGetCandidateTicketCount() {
//        let expection = expectation(description: "GetCandidateTicketCount")
//        let nodeIds = ["0x858d6f6ae871e291d3b7b2b91f7369f46deb6334e9dacb66fa8ba6746ee1f025bd4c090b17d17e0d9d5c19fdf81eb8bde3d40a383c9eecbe7ebda9ca95a3fb94","0xe4556b211eb6712ab94d743990d995c0d3cd15e9d78ec0096bba24c48d34f9f79a52ca1f835cec589c5e7daff30620871ba37d6f5f722678af4b2554a24dd75c"]
//
//        tContract.GetCandidateTicketCount(nodeIds: nodeIds) { (result, data) in
//            switch result {
//            case .success:
//                if let tickets = data as? String{
//                    print("GetCandidateTicketCount :" + tickets)
//                }
//                XCTAssertNotNil(data!, "GetCandidateTicketCount返回为空")
//                expection.fulfill()
//            case .fail(_, let errorMsg):
//                XCTAssertNil(errorMsg, errorMsg!)
//                expection.fulfill()
//            }
//        }
//        wait(for: [expection], timeout: 20)
//    }
}
