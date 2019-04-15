//
//  ViewController+extension.swift
//  platonWeb3Demo
//
//  Created by Ned on 23/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController{
    
    func showMessage(text: String, _ delay : TimeInterval = 3){
        SVProgressHUD.showInfo(withStatus: text)
        //SVProgressHUD.dismiss(withDelay: delay)
    }
    
    func showLoading(){
        SVProgressHUD.show()
    }
    
    func dismissHud(){
        SVProgressHUD.dismiss()
    }
    
}

