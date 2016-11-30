//
//  ActiveBillsController.swift
//  Congress Search
//
//  Created by Anush on 11/29/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class NewBillsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var bills = [JSON]()
    let mod = model()
    @IBOutlet var billsTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadNewBills, object: nil)
        self.mod.getNewBills()
    }
    func reloadTableData(_ notification: Notification) {
        bills = self.mod.newBills
        print(bills)
        billsTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newBillsCustomCell", for: indexPath) as! MyCustomNewTableViewCell
        
        if(bills.indices.contains(indexPath.row)) {
            //bill_id
            cell.firstLabel.text = bills[indexPath.row]["bill_id"].stringValue
            //official_title
            cell.secondLabel.text = bills[indexPath.row]["official_title"].stringValue
            //introduced_on
            cell.thirdLabel.text = bills[indexPath.row]["introduced_on"].stringValue
            
        }
        return cell
        
    }
    
    
    
}
