//
//  StateDetailsViewController.swift
//  Congress Search
//
//  Created by Anush on 11/28/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//
import SwiftyJSON
import Foundation
import UIKit
class StateDetailsViewController: UIViewController
    
//, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var detailImage: UIImageView!
    var leg = JSON("")
    var legDetails = JSON("")
    var legDetailsArray = ["String"]
    var legDetailsDetailsArray = [AnyObject]()

    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        print (self.leg)
       let filePath = "https://theunitedstates.io/images/congress/original/"+self.leg["bioguide_id"].stringValue+".jpg"
        self.detailImage.downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
        self.legDetailsArray = ["First Name","Last Name","State","Birth Date","Gender","Chamber","Fax No.","Twitter","Facebook","Website","Office No.","Term ends on"]
        self.legDetailsDetailsArray=[self.leg["first_name"].stringValue as AnyObject,self.leg["last_name"].stringValue as AnyObject,self.leg["state"].stringValue as AnyObject]
        self.legDetailsDetailsArray.append(self.leg["birthday"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["gender"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["chamber"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["fax"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["twitter_id"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["facebook_id"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["website"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["office"].stringValue as AnyObject)
        self.legDetailsDetailsArray.append(self.leg["term_end"].stringValue as AnyObject)


//        self.leg["gender"],self.leg["chamber"],self.leg["fax"],self.leg["twitter_id"],self.leg["facebook_id"],self.leg["website"],self.leg["office"], self.leg["term_end"])

//            "First Name" : self.leg["first_name"],
//            "Last Name" : self.leg["last_name"],
//            "State" : self.leg["state"],
//            "Birth Date" : self.leg["birthday"],
//            "Gender" : self.leg["gender"],
//            "Chamber" : self.leg["chamber"],
//            "Fax No." : self.leg["fax"],
//            "Twitter" : self.leg["twitter_id"],
//            "Facebook" : self.leg["facebook_id"],
//            "Website" : self.leg["website"],
//            "Office No." : self.leg["office"],
//            "Term ends on" : self.leg["term_end"]
        
        

        print (self.legDetailsDetailsArray)


        
        //downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

}
