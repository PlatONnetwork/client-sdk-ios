//
//  FirstDemoViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit
import BigInt

class VoteViewController: BaseTableViewController {

    let contract : TicketContract = TicketContract(web3: web3)
    
    var ticketIDs : [String] = []
    
    var ticketPrice: BigUInt?
    
    let candidateContract = CandidateContract(web3: web3)
    
    var nodeId : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        
        candidateContract.CandidateList { (result, data) in
            switch result{
                
            case .success:
                if let data = data as? String{
                    let obj = try? JSONSerialization.jsonObject(with: data.data(using: .utf8)!, options: [])
                    if let theArray = obj as? Array<Any>{
                        if let tmp = theArray.first as? Dictionary<String, Any>{
                            let nodeid = tmp["CandidateId"]
                            self.nodeId = nodeid as? String
                        }
                    }
                    
                }else{
                    self.showMessage(text: "error json rpc result")
                }
            case .fail(let _, let _):
                do{}
            }
        }
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.GetTicketPrice()
        case 1:
            self.GetPoolRemainder()
        case 2:
            self.GetCandidateEpoch()
        case 3:
            self.GetTicketDetail()
        case 4:
            self.GetBatchTicketDetail()
        case 5:
            self.GetBatchCandidateTicketIds()
        case 6:
            self.VoteTicket()

        default:
            do{}
        }
    }

    func GetTicketPrice(){
        contract.GetTicketPrice { (result, data) in
            switch result{
            case .success:
                if let price = data as? String{
                    let text = "price is:\(price)"
                    self.showMessage(text: text)
                    self.ticketPrice = BigUInt(price)!
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func GetPoolRemainder() {
        contract.GetPoolRemainder { (result, data) in
            switch result{
                
            case .success:
                if let remain = data as? String{
                    let text = "PoolRemainder is:\(remain)"
                    self.showMessage(text: text)
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func GetCandidateEpoch(){
        
        guard self.nodeId != nil else {
            self.showMessage(text: "nodeId is empty")
            return
        }
        
        contract.GetCandidateEpoch(candidateId: self.nodeId!) { (result, data) in
            switch result{
                
            case .success:
                if let epoch = data as? String{
                    let text = "CandidateEpoch is:\(epoch)"
                    self.showMessage(text: text)
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func GetTicketDetail(){
        guard self.ticketIDs.count > 0 else {
            self.showMessage(text: "ticketIDs count is 0, vote for candidate first!")
            return
        }
        contract.GetTicketDetail(ticketId: self.ticketIDs.first!) { (result, data) in
            switch result{
            case .success:
                if let detail = data as? String{
                    let text = "GetTicketDetail:\(detail)"
                    self.showMessage(text: text)
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func GetBatchTicketDetail(){
        
        guard self.ticketIDs.count > 0 else {
            self.showMessage(text: "ticketIDs count is 0, vote for candidate first!")
            return
        }
        self.showLoading()
        contract.GetBatchTicketDetail(ticketIds: self.ticketIDs) { (result, data) in
            switch result{
                
            case .success:
                if let detail = data as? String{
                    self.showMessage(text: "GetBatchTicketDetail :" + detail)
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func GetBatchCandidateTicketIds(){
        
        guard self.nodeId != nil else {
            self.showMessage(text: "nodeId is empty")
            return
        }
        
        contract.GetBatchCandidateTicketIds(nodeIds: [self.nodeId!]) { (result, data) in
            switch result{
                
            case .success:
                if let tickets = data as? String{
                    self.showMessage(text: "GetBatchCandidateTicketIds :" + tickets)
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    func VoteTicket(){
        
        guard (self.ticketPrice != nil) else {
            print("Get ticket price first!")
            return
        }
        
        
        
        
        candidateContract.CandidateList { (result, data) in
            switch result{
                
            case .success:
                if let data = data as? String{
                    let obj = try? JSONSerialization.jsonObject(with: data.data(using: .utf8)!, options: [])
                    if let theArray = obj as? Array<Any>{
                        if let tmp = theArray.first as? Dictionary<String, Any>{
                            let nodeid = tmp["CandidateId"]
                            self.onVoteWithNodeId(nodeId: nodeid as! String)
                        }
                    }
                    
                }else{
                    self.showMessage(text: "error json rpc result")
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
        
    }
    
    func onVoteWithNodeId(nodeId : String) {
        self.showLoading()
        contract.VoteTicket(count: 5, price: self.ticketPrice!, nodeId: nodeId, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas) { (result, data) in
            switch result{
                
            case .success:
                if let data = data as? Data{
                    print("vote hash is is:\(data.toHexString())")
                    
                    web3.eth.platonGetTransactionReceipt(txHash: data.toHexString(), loopTime: 15, completion: { (result, receipt) in
                        if let receipt = receipt as? EthereumTransactionReceiptObject{
                            if String((receipt.status?.quantity)!) == "1"{
                                let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                                if (rlpItem?.array?.count)! > 0{
                                    let message = ABI.stringDecode(data: Data(rlpItem!.array![0].bytes!))
                                    
                                    guard let dic = try? JSONSerialization.jsonObject(with: message.data(using: .utf8)!, options: .mutableContainers) as? [String:Any], let count = Int(dic?["Data"] as? String ?? "") else{
                                        let message = "Fatal Error: data parser error!"
                                        print(message)
                                        self.showMessage(text: message)
                                        
                                        return
                                    }
                                    
                                    //variable count is the vote numbers that take effect on chain
                                    //generate ticket from transaction hash
                                    let tickets = TicketContract.generateTickets(txHash: data, count: UInt32(count))
                                    let text = "ticket id:\(tickets)"
                                    print(text)
                                    self.showMessage(text: text)
                                    self.ticketIDs.append(contentsOf: tickets)
                                }
                            }else if String((receipt.status?.quantity)!) == "0"{
                                let message = "ERROR:VoteTicket receipt status: 0"
                                print(message)
                                self.showMessage(text: message)
                            }
                        }
                    })
                }
            case .fail(let code, let errMsg):
                let text = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: text)
            }
        }
    }
    
    
}
