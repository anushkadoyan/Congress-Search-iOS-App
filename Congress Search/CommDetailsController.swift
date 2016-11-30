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
    @IBOutlet var fav: UIBarButtonItem!
    var comm = JSON("")
    var commDetailsArray = ["String"]
    var commDetailsDetailsArray = ["String"]
    
    @IBOutlet var commTable: UITableView!
    
    @IBOutlet var commView: UITextView!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.commTable.tableFooterView = UIView()

    }
    
    
    @IBAction func favClicked(_ sender: Any) {
        if(favorites["comms"]?.contains(self.comm))! {
            favorites["comms"]?.remove(at: (favorites["comms"]?.index(of: self.comm))!)
        }
        else {
            favorites["comms"]?.append(self.comm)
        }
        if (self.fav.image == UIImage(named: "Star-50.png")) {
            self.fav.image = UIImage(named: "Star Filled-50.png")
        } else {
            self.fav.image = UIImage(named: "Star-50.png")
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
        if(favorites["comms"]?.contains(self.comm))! {
            print("contains")
            self.fav.image = UIImage(named: "Star Filled-50.png")
        }
        else {
            self.fav.image = UIImage(named: "Star-50.png")
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
