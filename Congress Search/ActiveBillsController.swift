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

class ActiveBillsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var billsTable: UITableView!
    var bills = [JSON]()
    let mod = model()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadActiveBills, object: nil)
        self.mod.getActiveBills()
    }
    func reloadTableData(_ notification: Notification) {
        bills = self.mod.activeBills
        billsTable.reloadData()
    }
    func convertDateFormater(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "dd MMM yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: date)
        
        return timeStamp
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bills.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activeBillsCustomCell", for: indexPath) as! MyCustomTableViewCell

        if(bills.indices.contains(indexPath.row)) {
        //bill_id
        cell.firstLabel.text = bills[indexPath.row]["bill_id"].stringValue
        //official_title
        cell.secondLabel.text = bills[indexPath.row]["official_title"].stringValue
        //introduced_on
            cell.thirdLabel.text = convertDateFormater(date:bills[indexPath.row]["introduced_on"].stringValue)
        
        }
        return cell

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "houseSeg",
            let nextScene = segue.destination as? HouseDetailsViewController ,
            let indexPath = self.billsTable.indexPathForSelectedRow {
            let selectedBill = bills[indexPath.row]
            nextScene.bill = selectedBill
        }
    }

    
    
}
