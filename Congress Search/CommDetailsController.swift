//
//  ActiveDetailsViewController.swift
//  Congress Search
//
//  Created by Anush on 11/29/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class CommDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    var comm = JSON("")
    var commDetailsArray = ["String"]
    var commDetailsDetailsArray = ["String"]
    
    @IBOutlet var commTable: UITableView!
    
    @IBOutlet var commView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.commTable.tableFooterView = UIView()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(self.comm)
        super.viewWillAppear(animated)
        self.commView.text = self.comm["name"].stringValue
        self.comm["chamber"].stringValue.capitalizeFirstLetter()

        self.commDetailsArray = ["ID","Parent ID", "Chamber","Office","Contact"]
        self.commDetailsDetailsArray=[self.comm["committee_id"].stringValue ,self.comm["parent_committee_id"].stringValue, self.comm["chamber"].stringValue, self.comm["office"].stringValue, self.comm["phone"].stringValue]
        for var thing in self.commDetailsDetailsArray {
            if (thing  == nil || thing.characters.count == 0)  {
                self.commDetailsDetailsArray[self.commDetailsDetailsArray.index(of:thing)!] = "N.A."
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commDetailsDetailsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "commDetail", for: indexPath)
        if(self.commDetailsArray.indices.contains(indexPath.row)) {
            cell.textLabel?.text = self.commDetailsArray[indexPath.row]
            
            cell.detailTextLabel?.text =   self.commDetailsDetailsArray[indexPath.row]
        }
        return cell
    }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    
  
    
    
}
