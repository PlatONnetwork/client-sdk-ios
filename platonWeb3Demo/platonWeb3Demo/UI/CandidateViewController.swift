//
//  CandidateViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit

class CandidateViewController: BaseTableViewController {

    var contract = CandidateContract(web3: web3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.CandidateDeposit()
        case 1:
            self.CandidateApplyWithdraw()
        case 2:
            self.CandidateWithdraw()
        case 3:
            self.SetCandidateExtra()
        case 4:
            self.CandidateWithdrawInfos()
        case 5:
            self.CandidateDetails()
        case 6:
            self.GetBatchCandidateDetail()
        case 7:
            self.CandidateList()
        case 8:
            self.VerifiersList()
        case 9:
            do{}
        default:
            do{}
        }
    }

    //MARK: - Contracts
    
    func CandidateDeposit(){
        let nodeId = "0xaafbc9c699270bd33c77f1b2a5c3653eaf756f1860891327dfd8c29960a51c9aebb6c081cbfe2499db71e9f4c19e609f44cbd9514e59b6066e5e895b8b592abf";//节点id
        let owner = "0x493301712671ada506ba6ca7891f436d29185821"; //质押金退款地址
        let fee = UInt64(500)
        let host = "192.168.9.76"; //节点IP
        let port = "38789"; //节点P2P端口号
        
        var extra : Dictionary<String,String> = [:]
        extra["nodeName"] = "xxxx-noedeName"
        extra["nodePortrait"] = "1"
        extra["nodeDiscription"] = "xxxx-nodeDiscription"
        extra["nodeDepartment"] = "xxxx-nodeDepartment"
        extra["officialWebsite"] = "https://www.platon.network/"
        
        var theJSONText : String = ""
        if let theJSONData = try? JSONSerialization.data(withJSONObject: extra,options: []) {
            theJSONText = String(data: theJSONData,
                                 encoding: .utf8)!
        }
        
        contract.CandidateDeposit(nodeId: nodeId, owner: owner, fee: fee, host: host, port: port, extra: theJSONText, sender: sender, privateKey: privateKey, gasPrice: gasPrice, gas: gas, value: BigUInt("1000000000000000000")!) { (result, data) in
            switch result{
            case .success:
                let message = "Transaction success"
                print(message)
                self.showMessage(text: message)
                
                if let data = data as? Data{
                    web3.eth.platonGetTransactionReceipt(txHash: data.toHexString(), loopTime: 15, completion: { (result, receipt) in
                        if let receipt = receipt as? EthereumTransactionReceiptObject{
                            if String((receipt.status?.quantity)!) == "1"{
                                let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                                if (rlpItem?.array?.count)! > 0{
                                    let message = ABI.stringDecode(data: Data(rlpItem!.array![0].bytes!))
                                    print(message)
                                    self.showMessage(text: message)
                                    
                                }
                                print("CandidateDeposit success")
                            }else if String((receipt.status?.quantity)!) == "0"{
                                let message = "ERROR:CandidateDeposit receipt status: 0"
                                self.showMessage(text: message)
                            }
                        }
                    })
                }else{
                    let message = "CandidateDeposit empty transaction hash"
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func CandidateApplyWithdraw(){
        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";
        //退款金额, 单位 wei
        let value = BigUInt("500")!
        //must be owner
        let owner = "f8f3978c14f585c920718c27853e2380d6f5db36"
        let ownerPrivateKey = "74df7c508a4e20a3da81b331e2168cff9e6bc085e1968a30a05daf85ae654ed6"
        contract.CandidateApplyWithdraw(nodeId: nodeId,withdraw: value,sender: owner,privateKey: ownerPrivateKey,gasPrice: gasPrice,gas: gas,value: BigUInt(0)) { (result, data) in
            switch result{
            case .success:

                let message = "CandidateApplyWithdraw success"
                print(message)
                self.showMessage(text: message)
                if let data = data as? Data{
                    web3.eth.platonGetTransactionReceipt(txHash: data.toHexString(), loopTime: 15, completion: { (result, receipt) in
                        if let receipt = receipt as? EthereumTransactionReceiptObject{
                            if String((receipt.status?.quantity)!) == "1"{
                                let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                                if (rlpItem?.array?.count)! > 0{
                                    let message = ABI.stringDecode(data: Data(rlpItem!.array![0].bytes!))
                                    print("message:\(message)")
                                }
                                let message = "CandidateApplyWithdraw success"
                                print(message)
                                self.showMessage(text: message)
                            }else if String((receipt.status?.quantity)!) == "0"{
                                let message = "ERROR:CandidateApplyWithdraw receipt status: 0"
                                print(message)
                                self.showMessage(text: message)
                            }
                        }
                    })
                }else{
                    let message = "CandidateApplyWithdraw empty transaction hash"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    
    func CandidateWithdraw(){
        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";
        contract.CandidateWithdraw(nodeId: nodeId,sender: sender,privateKey: privateKey,gasPrice: gasPrice,gas: gas,value: BigUInt(0)) { (result, data) in
            switch result{
            case .success:
                let message = "send Transaction success"
                print(message)
                self.showMessage(text: message)
                
                if let data = data as? Data{
                    web3.eth.platonGetTransactionReceipt(txHash: data.toHexString(), loopTime: 15, completion: { (result, receipt) in
                        if let receipt = receipt as? EthereumTransactionReceiptObject{
                            if String((receipt.status?.quantity)!) == "1"{
                                let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                                if (rlpItem?.array?.count)! > 0{
                                    let message = ABI.stringDecode(data: Data(rlpItem!.array![0].bytes!))
                                    print("message:\(message)")
                                }
                                let message = "CandidateWithdraw success"
                                print(message)
                                self.showMessage(text: message)
                            }else if String((receipt.status?.quantity)!) == "0"{
                                let message = "ERROR:CandidateWithdraw receipt status: 0"
                                print(message)
                                self.showMessage(text: message)
                            }
                        }
                    })
                }else{
                    let message = "CandidateWithdraw empty transaction hash"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func SetCandidateExtra(){
        let nodeId = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3";//节点id
        var extra : Dictionary<String,String> = [:]
        extra["nodeName"] = "xxxx-noedeName"
        extra["nodePortrait"] = "2"
        extra["nodeDiscription"] = "xxxx-nodeDiscription1"
        extra["nodeDepartment"] = "xxxx-nodeDepartment"
        extra["officialWebsite"] = "xxxx-officialWebsite"
        
        var theJSONText : String = ""
        if let theJSONData = try? JSONSerialization.data(withJSONObject: extra,options: []) {
            theJSONText = String(data: theJSONData,
                                 encoding: .utf8)!
        }
        //must be owner
        let owner = "f8f3978c14f585c920718c27853e2380d6f5db36"
        let ownerPrivateKey = "74df7c508a4e20a3da81b331e2168cff9e6bc085e1968a30a05daf85ae654ed6"
        self.showLoading()
        contract.SetCandidateExtra(nodeId: nodeId, extra: theJSONText, sender: owner, privateKey: ownerPrivateKey, gasPrice: gasPrice, gas: gas, value: nil) { (result, data) in
            switch result{
            case .success:
                print("send Transaction success")
                if let data = data as? Data{
                    web3.eth.platonGetTransactionReceipt(txHash: data.toHexString(), loopTime: 15, completion: { (result, receipt) in
                        if let receipt = receipt as? EthereumTransactionReceiptObject{
                            if String((receipt.status?.quantity)!) == "1"{
                                let rlpItem = try? RLPDecoder().decode((receipt.logs.first?.data.bytes)!)
                                if (rlpItem?.array?.count)! > 0{
                                    let message = ABI.stringDecode(data: Data(rlpItem!.array![0].bytes!))
                                    print("message:\(message)")
                                }
                                let message = "SetCandidateExtra success"
                                print(message)
                                self.showMessage(text: message)
                            }else if String((receipt.status?.quantity)!) == "0"{
                                let message = "ERROR:SetCandidateExtra receipt status: 0"
                                print(message)
                                self.showMessage(text: message)
                            }
                        }
                    })
                }else{
                    let message = "SetCandidateExtra empty transaction hash"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func CandidateWithdrawInfos() {
        self.showLoading()
        contract.CandidateWithdrawInfos(nodeId: "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3") { (result, data) in
            switch result{
            case .success:
                if let data = data as? String{
                    let message = "result:\(data)"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func CandidateDetails(){
        self.showLoading()
        contract.CandidateDetails(nodeId: "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3") { (result, data) in
            switch result{
            case .success:
                if let data = data as? String{
                    let message = "result:\(data)"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func GetBatchCandidateDetail(){
       var nodes = "0x6bad331aa2ec6096b2b6034570e1761d687575b38c3afc3a3b5f892dac4c86d0fc59ead0f0933ae041c0b6b43a7261f1529bad5189be4fba343875548dc9efd3"
        nodes = nodes + ":"
        nodes = nodes + "0xc0e69057ec222ab257f68ca79d0e74fdb720261bcdbdfa83502d509a5ad032b29d57c6273f1c62f51d689644b4d446064a7c8279ff9abd01fa846a3555395535"
        self.showLoading()
        contract.GetBatchCandidateDetail(batchNodeIds: nodes) { (result, data) in
            switch result{
            case .success:
                if let data = data as? String{
                    let message = "result:\(data)"
                    self.showMessage(text: message)
                    print(message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    
    func CandidateList(){
        self.showLoading()
        contract.CandidateList { (result, data) in
            switch result{
            case .success:
                if let data = data as? String{
                    let message = "result:\(data)"
                    print(message)
                    self.showMessage(text: message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    func VerifiersList(){
        self.showLoading()
        contract.VerifiersList { (result, data) in
            switch result{
            case .success:
                if let data = data as? String{
                    let message = "result:\(data)"
                    self.showMessage(text: message)
                    print(message)
                }
            case .fail(let code, let errMsg):
                let message = "error code:\(code ?? 0) errMsg:\(errMsg ?? "")"
                self.showMessage(text: message)
                print("error code:\(code ?? 0) errMsg:\(errMsg ?? "")")
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    }
    

    
    
    
    



