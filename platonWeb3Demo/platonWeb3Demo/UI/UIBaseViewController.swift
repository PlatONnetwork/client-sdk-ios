//
//  UIBaseViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 23/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import SVProgressHUD
class BaseTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onNotification), name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    }
    
    @objc func onNotification(){
        SVProgressHUD.dismiss()
    }
}
