//
//  FirstViewController.swift
//  Congress Search
//
//  Created by Anush on 11/23/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var legs = [JSON]()
    let mod = model()
    @IBOutlet weak var legTable: UITableView!
    var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        legTable.delegate = self
        legTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        self.mod.getLegsHouse()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func reloadTableData(_ notification: Notification) {
        print("reload")
        
//        let APIdata = notification.object as! JSON
//        legs = APIdata[4]["results"].array!
        legs = self.mod.legHouse

        print(legs)

        legTable.reloadData()
    }
    
    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "legHouseCell", for: indexPath)
        if(legs.indices.contains(indexPath.row)) {
            cell.textLabel?.text = legs[indexPath.row]["last_name"].stringValue + ", " + legs[indexPath.row]["first_name"].stringValue
            let state = self.states[legs[indexPath.row]["state"].stringValue]
            cell.detailTextLabel?.text = state
            //            var filePath = "https://theunitedstates.io/images/congress/original/"+legs[indexPath.row]["]bioguide_id"].stringValue+".jpg"
            //            if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
            //                cell.contentView.contentMode = .scaleAspectFit
            //                cell.contentView.im = image
            //            }
            //   cell.imageView? = load_image("https://theunitedstates.io/images/congress/original/"+legs[indexPath.row]["]bioguide_id"]+".jpg")
            
        }
        //        print(tableTitle[indexPath.row])
        //        cell.detailTextLabel?.body!.text = tableBody[indexPath.row]
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

