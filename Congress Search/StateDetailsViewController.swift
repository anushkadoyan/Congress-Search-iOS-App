//
//  StateDetailsViewController.swift
//  Congress Search
//
//  Created by Anush on 11/28/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON


class StateDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var detailImage: UIImageView!
    var leg = JSON("")
    var legDetails = JSON("")
    var legDetailsArray = ["String"]
    var legDetailsDetailsArray = ["String"]

//    @IBOutlet weak var legDetailsTable: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var legDetailsTable: UITableView!
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        print(self.leg)

        let state = self.states[(self.leg["state"].stringValue)]
        let termEnd =  (convertDateFormater(date: self.leg["term_end"].stringValue))
        let birthday =  (convertDateFormater(date: self.leg["birthday"].stringValue))
        if (self.leg["gender"].stringValue=="M") {
            self.leg["gender"].stringValue = "Male"
        } else {
            self.leg["gender"].stringValue = "Female"
        }
      self.leg["chamber"].stringValue.capitalizeFirstLetter()
       let filePath = "https://theunitedstates.io/images/congress/original/"+self.leg["bioguide_id"].stringValue+".jpg"
        self.detailImage.downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
        self.legDetailsArray = ["First Name","Last Name","State","Birth Date","Gender","Chamber","Fax No.","Twitter","Facebook","Website","Office No.","Term ends on"]
        self.legDetailsDetailsArray=[self.leg["first_name"].stringValue ,self.leg["last_name"].stringValue ,state! ]
        self.legDetailsDetailsArray.append(birthday )
        self.legDetailsDetailsArray.append(self.leg["gender"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["chamber"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["fax"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["twitter_id"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["facebook_id"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["website"].stringValue )
        self.legDetailsDetailsArray.append(self.leg["office"].stringValue )
        self.legDetailsDetailsArray.append(termEnd )
        for var thing in self.legDetailsDetailsArray {
            print(thing.characters.count)
            if (thing  == nil || thing.characters.count == 0)  {
                
                self.legDetailsDetailsArray[self.legDetailsDetailsArray.index(of:thing)!] = "N.A."
//                print(key)
//                self.legDetailsDetailsArray[key] = "N.A."
            }
            
        }

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.legDetailsArray.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "stateDetail", for: indexPath)
        if(self.legDetailsArray.indices.contains(indexPath.row)) {
            cell.textLabel?.text = self.legDetailsArray[indexPath.row]
            cell.detailTextLabel?.text = legDetailsDetailsArray[indexPath.row] as! String
        
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
