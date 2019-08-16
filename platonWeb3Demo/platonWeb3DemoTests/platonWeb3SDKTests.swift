//
//  platonWeb3SDKTests.swift
//  platonWeb3DemoTests
//
//  Created by Admin on 10/6/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import XCTest
@testable import platonWeb3Demo

class platonWeb3SDKTests: XCTestCase {
    
    var web3: Web3!
    var sender: String!
    var privateKey: String!
    var gasPrice: BigUInt!
    var gas: BigUInt!
    var senderAddress: EthereumAddress!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        web3 = Web3(rpcURL: "http://10.10.8.21:6789")
        sender = "0x493301712671Ada506ba6Ca7891F436D29185821"
        privateKey = "a11859ce23effc663a9460e332ca09bd812acc390497f8dc7542b6938e13f8d7"
        gasPrice = BigUInt("1000000000")!
        gas = BigUInt("240943980")!
        senderAddress = EthereumAddress(hexString: sender)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testProtocolVersion() {
        let expection = expectation(description: "protocolVersion")
        web3.eth.protocolVersion { (result) in
            print(result)
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testSyncing() {
        let expection = expectation(description: "syncing")
        web3.eth.syncing { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGasPrice() {
        let expection = expectation(description: "gasPrice")
        web3.eth.gasPrice { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testAccounts() {
        let expection = expectation(description: "accounts")
        web3.eth.accounts { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testBlockNumber() {
        let expection = expectation(description: "blockNumber")
        web3.eth.blockNumber { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetBalance() {
        let expection = expectation(description: "getBalance")
        web3.eth.getBalance(address: senderAddress, block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetStorageAt() {
        let expection = expectation(description: "getStorageAt")
        web3.eth.getStorageAt(address: senderAddress, position: .init(quantity: BigUInt("1")), block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetTransactionCount() {
        let expection = expectation(description: "getTransactionCount")
        web3.eth.getTransactionCount(address: senderAddress, block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetBlockTransactionCountByHash() {
        let expection = expectation(description: "getBlockTransactionCountByHash")
        web3.eth.getBlockTransactionCountByHash(blockHash: EthereumData(bytes: Data(hex: "0x442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8").bytes)) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetBlockTransactionCountByNumber() {
        let expection = expectation(description: "getBlockTransactionCountByNumber")
        web3.eth.getBlockTransactionCountByNumber(block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetCode() {
        let expection = expectation(description: "getCode")
        web3.eth.getCode(address: EthereumAddress(hexString: "0x093acd8ff0b8ac2cd1491571142205474342e887")!, block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testSendTransaction() {
        let expection = expectation(description: "sendTransaction")
        web3.eth.getTransactionCount(address: senderAddress, block: .latest) { (result) in
            let transaction = EthereumTransaction(nonce: result.result, gasPrice: EthereumQuantity(quantity: self.gasPrice), gas: EthereumQuantity(quantity: self.gas), from: self.senderAddress, to: EthereumAddress(hexString: "0x493301712671ada506ba6ca7891f436d29185821")!, value: EthereumQuantity(integerLiteral: 100), data: EthereumData(bytes: [0x00]))
            self.web3.eth.sendTransaction(transaction: transaction, response: { (result) in
                expection.fulfill()
            })
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testSendRawTransaction() {
        let expection = expectation(description: "sendRawTransaction")
        web3.eth.getTransactionCount(address: senderAddress, block: .latest) { (result) in
            let transaction = EthereumSignedTransaction(nonce: result.result!, gasPrice: EthereumQuantity(quantity: self.gasPrice), gasLimit: EthereumQuantity(quantity: self.gas), to: EthereumAddress(hexString: "0x493301712671ada506ba6ca7891f436d29185821")!, value: EthereumQuantity(integerLiteral: 100), data: EthereumData(bytes: [0x00]), v: EthereumQuantity(integerLiteral: 1), r: EthereumQuantity(integerLiteral: 1), s: EthereumQuantity(integerLiteral: 1), chainId: EthereumQuantity(integerLiteral: 1))
            self.web3.eth.sendRawTransaction(transaction: transaction, response: { (rsult) in
                expection.fulfill()
            })
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testCall() {
        let expection = expectation(description: "call")
        let call = EthereumCall(from: senderAddress, to: EthereumAddress(hexString: "0x493301712671ada506ba6ca7891f436d29185821")!, gas: EthereumQuantity(quantity: gas), gasPrice: EthereumQuantity(quantity: gasPrice), value: EthereumQuantity(integerLiteral: 100), data: EthereumData(bytes: [0x00]))
        web3.eth.call(call: call, block: .latest) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testEstimateGas() {
        let expection = expectation(description: "estimateGas")
        let call = EthereumCall(from: senderAddress, to: EthereumAddress(hexString: "0x493301712671ada506ba6ca7891f436d29185821")!, gas: EthereumQuantity(quantity: gas), gasPrice: EthereumQuantity(quantity: gasPrice), value: EthereumQuantity(integerLiteral: 100), data: EthereumData(bytes: [0x00]))
        web3.eth.estimateGas(call: call) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetBlockByHash() {
        let expection = expectation(description: "getBlockByHash")
        let data = EthereumData(bytes: Data(hex: "0x442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8").bytes)
        
        web3.eth.getBlockByHash(blockHash: data, fullTransactionObjects: true) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetBlockByNumber() {
        let expection = expectation(description: "getBlockByNumber")
        web3.eth.getBlockByNumber(block: .latest, fullTransactionObjects: true) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetTransactionByHash() {
        let expection = expectation(description: "getTransactionByHash")
        let data = EthereumData(bytes: Data(hex: "0x442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8").bytes)
        web3.eth.getTransactionByHash(blockHash: data) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetTransactionByBlockHashAndIndex() {
        let expection = expectation(description: "getTransactionByBlockHashAndIndex")
        let data = EthereumData(bytes: Data(hex: "0x442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8").bytes)
        web3.eth.getTransactionByBlockHashAndIndex(blockHash: data, transactionIndex: EthereumQuantity(integerLiteral: 1)) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetTransactionByBlockNumberAndIndex() {
        let expection = expectation(description: "getTransactionByBlockNumberAndIndex")
        web3.eth.getTransactionByBlockNumberAndIndex(block: .latest, transactionIndex: EthereumQuantity(integerLiteral: 1)) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }
    
    func testGetTransactionReceipt() {
        let expection = expectation(description: "getTransactionReceipt")
        let data = EthereumData(bytes: Data(hex: "0x442c026b4d6bf8ad34fa1e509d988ac100021ca7d1070627f0028316a6b5cfc8").bytes)
        web3.eth.getTransactionReceipt(transactionHash: data) { (result) in
            expection.fulfill()
        }
        wait(for: [expection], timeout: 15)
    }

}
