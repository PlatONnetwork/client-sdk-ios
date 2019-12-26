//
//  FirstDemoViewController.swift
//  platonWeb3Demo
//
//  Created by Ned on 9/1/2019.
//  Copyright © 2019 ju. All rights reserved.
//

import UIKit
import platonWeb3

class FirstDemoViewController: BaseTableViewController {

    var firstdemoContract = firstdemo()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        
        let result = "0x7b22537461747573223a747275652c2244617461223a225b7b5c224e6f646549645c223a5c2231663361383637323334386666366237383965343136373632616435336536393036333133386238656234643837383031303136353866323462323336396631613865303934393932323662343637643862633063346530336531646339303364663835376565623363363737333364323162366161656532383432323333345c222c5c225374616b696e67416464726573735c223a5c223078303030303030373430636533316233666163323064616333373964623234333032316135316538305c222c5c2242656e69666974416464726573735c223a5c223078313030303030303030303030303030303030303030303030303030303030303030303030303030325c222c5c225374616b696e675478496e6465785c223a302c5c2250726f6365737356657273696f6e5c223a302c5c225374616b696e67426c6f636b4e756d5c223a322c5c225368617265735c223a3235362c5c2245787465726e616c49645c223a5c2278786363636364646464646464645c222c5c224e6f64654e616d655c223a5c224920416d20305c222c5c22576562736974655c223a5c227777772e62616964752e636f6d5c222c5c2244657461696c735c223a5c227468697320697320206261696475207e7e5c222c5c2256616c696461746f725465726d5c223a327d2c7b5c224e6f646549645c223a5c2232663361383637323334386666366237383965343136373632616435336536393036333133386238656234643837383031303136353866323462323336396631613865303934393932323662343637643862633063346530336531646339303364663835376565623363363737333364323162366161656532383433353436365c222c5c225374616b696e67416464726573735c223a5c223078373430636533316233666163323064616333373964623234333032316135316538303434343535355c222c5c2242656e69666974416464726573735c223a5c223078313030303030303030303030303030303030303030303030303030303030303030303030303030325c222c5c225374616b696e675478496e6465785c223a312c5c2250726f6365737356657273696f6e5c223a312c5c225374616b696e67426c6f636b4e756d5c223a332c5c225368617265735c223a3235362c5c2245787465726e616c49645c223a5c2278786363636364646464646464645c222c5c224e6f64654e616d655c223a5c224920416d20315c222c5c22576562736974655c223a5c227777772e62616964752e636f6d5c222c5c2244657461696c735c223a5c227468697320697320206261696475207e7e5c222c5c2256616c696461746f725465726d5c223a327d2c7b5c224e6f646549645c223a5c2233663361383637323334386666366237383965343136373632616435336536393036333133386238656234643837383031303136353866323462323336396631613865303934393932323662343637643862633063346530336531646339303364663835376565623363363737333364323162366161656532383534343837385c222c5c225374616b696e67416464726573735c223a5c223078303030303030373430636533316233666163323064616333373964623234333032316135316538305c222c5c2242656e69666974416464726573735c223a5c223078313030303030303030303030303030303030303030303030303030303030303030303030303030325c222c5c225374616b696e675478496e6465785c223a322c5c2250726f6365737356657273696f6e5c223a342c5c225374616b696e67426c6f636b4e756d5c223a342c5c225368617265735c223a3235362c5c2245787465726e616c49645c223a5c2278786363636364646464646464645c222c5c224e6f64654e616d655c223a5c224920416d20325c222c5c22576562736974655c223a5c227777772e62616964752e636f6d5c222c5c2244657461696c735c223a5c227468697320697320206261696475207e7e5c222c5c2256616c696461746f725465726d5c223a327d2c7b5c224e6f646549645c223a5c2233663361383637323334386666366237383965343136373632616435336536393036333133386238656234643837383031303136353866323462323336396631613865303934393932323662343637643862633063346530336531646339303364663835376565623363363737333364323162366161656532383536343634365c222c5c225374616b696e67416464726573735c223a5c223078303030303030373430636533316233666163323064616333373964623234333032316135316538305c222c5c2242656e69666974416464726573735c223a5c223078313030303030303030303030303030303030303030303030303030303030303030303030303030325c222c5c225374616b696e675478496e6465785c223a332c5c2250726f6365737356657273696f6e5c223a392c5c225374616b696e67426c6f636b4e756d5c223a352c5c225368617265735c223a3235362c5c2245787465726e616c49645c223a5c2278786363636364646464646464645c222c5c224e6f64654e616d655c223a5c224920416d20335c222c5c22576562736974655c223a5c227777772e62616964752e636f6d5c222c5c2244657461696c735c223a5c227468697320697320206261696475207e7e5c222c5c2256616c696461746f725465726d5c223a327d5d222c224572724d7367223a226f6b227d"
        
        let bytes = Bytes(hex: result)
        let content = String(bytes: bytes)
        let data = content.data(using: .utf8)!
        let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        
        print("============")
        print(json)
        
        let address = EthereumAddress(hexString: "0x12c171900f010b17e969702efa044d077e868082")
        guard let eth_address = address else {
            print("not transfer")
            return
        }
        let addressrlp = RLPItem(bytes: eth_address.rawAddress)
        let rawrlp = try? RLPEncoder().encode(addressrlp)
        print(rawrlp!.toHexString())
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        switch indexPath.row {
//        case 0:
//            firstdemoContract.deploy {
//
//            }
//        case 1:
//            firstdemoContract.invokeNotify(msg: "hello world!")
//        case 2:
//            firstdemoContract.Notify()
//        case 3:
//            firstdemoContract.getName()
//
//        default:
//            do{}
//        }
    }

    
    

}
