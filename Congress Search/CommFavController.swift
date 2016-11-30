//
//  LegFavController.swift
//  Congress Search
//
//  Created by Anush on 11/30/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner
class CommFavController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var legTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadCommFav, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: .reloadAgain, object: nil)
        
    }
    
    @IBAction func menuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    
    func reloadTableData(_ notification: Notification) {
        legTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites["comms"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commFavCell", for: indexPath)
        cell.textLabel?.text = favorites["comms"]?[indexPath.row]["name"].stringValue
        
        //(contacts[letters[indexPath.section]]?[indexPath.row]
        
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commFavSeg",
            let nextScene = segue.destination as? CommDetailsViewController ,
            let indexPath = self.legTable.indexPathForSelectedRow {
            let selectedLeg = favorites["comms"]?[indexPath.row]
            nextScene.comm = selectedLeg!
            
        }
    }
    
    
    
    
}

