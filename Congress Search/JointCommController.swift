//
//  ActivecommsController.swift
//  Congress Search
//
//  Created by Anush on 11/29/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class JointCommController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var comms = [JSON]()
    let mod = model()

    @IBOutlet var commsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadJointComms, object: nil)
        self.mod.getJointComms()
    }
    func reloadTableData(_ notification: Notification) {
        self.comms = self.mod.jointComms
//        print(self.comms)
        self.commsTable.reloadData()
    }
    
    
    @IBAction func menuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jointCommsCell", for: indexPath)
        
        if(self.comms.indices.contains(indexPath.row)) {
            
            cell.textLabel?.text = self.comms[indexPath.row]["name"].stringValue
            cell.detailTextLabel?.text = self.comms[indexPath.row]["committee_id"].stringValue
            //    cell.detailTextLabel?.text = state
            
            
        }
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commDetailSeg",
            let nextScene = segue.destination as? CommDetailsViewController ,
            let indexPath = self.commsTable.indexPathForSelectedRow {
            let selectedBill = self.comms[indexPath.row]
            nextScene.comm = selectedBill
        }
    }
    
    
    
}
