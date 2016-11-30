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

class ActiveDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
 {
    var bill = JSON("")
    var billDetailsArray = ["String"]
    var billDetailsDetailsArray = ["String"]

    @IBOutlet var fav: UIBarButtonItem!
    @IBOutlet var backButton: UIBarButtonItem!
    
    @IBOutlet var billView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func favClicked(_ sender: Any) {
        if(favorites["bills"]?.contains(self.bill))! {
            favorites["bills"]?.remove(at: (favorites["bills"]?.index(of: self.bill))!)
        }
        else {
            favorites["bills"]?.append(self.bill)
        }
        if (self.fav.image == UIImage(named: "Star-50.png")) {
            self.fav.image = UIImage(named: "Star Filled-50.png")
        } else {
            self.fav.image = UIImage(named: "Star-50.png")
        }
        NotificationCenter.default.post(name: .reloadBillFav, object: nil)


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

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        self.billView.text = self.bill["official_title"].stringValue
        var chamber = self.bill["chamber"].stringValue
        chamber.capitalizeFirstLetter()
        let lastAction = (convertDateFormater(date: bill["last_version"]["issued_on"].stringValue))
        let billType = self.bill["bill_type"].stringValue.uppercased()
        var sponsor = self.bill["sponsor"]["title"].stringValue
        sponsor = sponsor + " "
        sponsor = sponsor + self.bill["sponsor"]["first_name"].stringValue
        sponsor = sponsor + " "
        sponsor = sponsor + self.bill["sponsor"]["last_name"].stringValue
        let pdf = self.bill["last_version"]["urls"]["pdf"].stringValue
        var status = ""
        if(self.bill["history"]["active"].stringValue == "true") {
             status = "Active"
        }
        else {
             status = "New"
        }
        self.billDetailsArray = ["Bill ID","Bill Type", "Sponsor","Last Action","PDF","Chamber","Status"]
        self.billDetailsDetailsArray=[self.bill["bill_id"].stringValue ,billType, sponsor, lastAction,pdf,self.bill["chamber"].stringValue, status]
        for var thing in self.billDetailsDetailsArray {
            if (thing  == nil || thing.characters.count == 0)  {
                self.billDetailsDetailsArray[self.billDetailsDetailsArray.index(of:thing)!] = "N.A."
            }
        }
        if(favorites["bills"]?.contains(self.bill))! {
            print("contains")
            self.fav.image = UIImage(named: "Star Filled-50.png")
        }
        else {
            self.fav.image = UIImage(named: "Star-50.png")
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.billDetailsArray.count
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row==4) {
            //twitter
            let url = URL(string: billDetailsDetailsArray[indexPath.row])
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activeDetail", for: indexPath)
        if(self.billDetailsArray.indices.contains(indexPath.row)) {
            cell.textLabel?.text = self.billDetailsArray[indexPath.row]
            if(self.billDetailsArray[indexPath.row] == "PDF" && billDetailsDetailsArray[indexPath.row] != "N.A.") {
                let linkAttributes = [
                    NSLinkAttributeName: NSURL(string: billDetailsDetailsArray[indexPath.row])!,
                    NSForegroundColorAttributeName: UIColor.blue
                    ] as [String : Any]
                
                let attributedString = NSMutableAttributedString(string: "PDF Link")
                
                // Set the 'click here' substring to be the link
                attributedString.setAttributes(linkAttributes, range: NSMakeRange(0, 8))
                cell.detailTextLabel?.attributedText = attributedString

            }
            else {
                cell.detailTextLabel?.text =   billDetailsDetailsArray[indexPath.row]
            }
        }
        return cell
    }
    
    
    
    
    
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    

}
