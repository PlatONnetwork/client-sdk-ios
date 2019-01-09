//
//  CandidateViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit

class CandidateViewController: UITableViewController {

    var contract = CandidateContract()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            contract.CandidateDeposit()
        case 1:
            do{}
        case 2:
            do{}
        case 3:
            do{}
            
        default:
            do{}
        }
    }

}
