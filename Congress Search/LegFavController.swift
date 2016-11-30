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
class LegFavController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var legTable: UITableView!
    
    var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reloadLegFav, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: .reloadAgain, object: nil)
        
    }
    @IBAction func menuClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    func reloadTableData(_ notification: Notification) {
        legTable.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites["legs"]!.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "legFavCell", for: indexPath)
        let name = (favorites["legs"]?[indexPath.row]["last_name"].stringValue)! + ", " + (favorites["legs"]?[indexPath.row]["first_name"].stringValue)!
        cell.textLabel?.text = name
        let state = self.states[(favorites["legs"]?[indexPath.row]["state"].stringValue)!]
        let filePath = "https://theunitedstates.io/images/congress/original/"+(favorites["legs"]?[indexPath.row]["bioguide_id"].stringValue)!+".jpg"
        
        //(contacts[letters[indexPath.section]]?[indexPath.row]
        cell.imageView?.image = UIImage(named: "placeholder.jpg")
        
        cell.imageView?.downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
        cell.imageView?.clipsToBounds = true

        cell.detailTextLabel?.text = state
        return cell

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "legFavSeg",
            let nextScene = segue.destination as? StateDetailsViewController ,
            let indexPath = self.legTable.indexPathForSelectedRow {
            let selectedLeg = favorites["legs"]?[indexPath.row]
            nextScene.leg = selectedLeg!
            
        }
    }




}

