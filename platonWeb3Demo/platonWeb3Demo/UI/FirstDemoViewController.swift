//
//  FirstDemoViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit
import BigInt

class FirstDemoViewController: UITableViewController {

    var firstdemoContract = firstdemo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        
        
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            firstdemoContract.deploy {
                
            }
        case 1:
            firstdemoContract.invokeNotify(msg: "hello world!")
        case 2:
            firstdemoContract.Notify()
        case 3:
            firstdemoContract.getName()

        default:
            do{}
        }
    }

    
    

}
