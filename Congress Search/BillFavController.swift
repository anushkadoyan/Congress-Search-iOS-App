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
class BillFavController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var legTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadBillFav, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: .reloadAgain, object: nil)
        
    }

    @IBAction func menuClick(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    
    func reloadTableData(_ notification: Notification) {
        legTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites["bills"]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "billFavCell", for: indexPath)
        cell.textLabel?.text = favorites["bills"]?[indexPath.row]["official_title"].stringValue
        
        //(contacts[letters[indexPath.section]]?[indexPath.row]
        
        
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "billFavSeg",
            let nextScene = segue.destination as? ActiveDetailsViewController ,
            let indexPath = self.legTable.indexPathForSelectedRow {
            let selectedLeg = favorites["bills"]?[indexPath.row]
            nextScene.bill = selectedLeg!
            
        }
    }
    
    
    
    
}

