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
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var legTable: UITableView!
    var legs = [JSON]()
    let mod = model()

    var letters: [Character] = []
    var data: [String] = []
    var nameData: [String] = []

    var contacts = [Character: [JSON]]()
    
     var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        legTable.delegate = self
        legTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        self.mod.getLegs()

//        self.mod.getJSON(index:0)
            // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func reloadTableData(_ notification: Notification) {
//        let APIdata = notification.object as! JSON
//        legs = APIdata[0]["results"].array!
        legs = self.mod.leg
        if(legs.count>0) {
            for item in legs {
                data.append(item["state"].stringValue)
            }
           
            letters = data.map { (name) -> Character in
                return name[name.startIndex]
            }
            letters = letters.sorted()
            letters = letters.reduce([], { (list, name) -> [Character] in
                if !list.contains(name) {
                    return list + [name]
                }
                return list
            })
            for item in legs {
                nameData.append(item["last_name"].stringValue+", "+item["first_name"].stringValue)
            }
            for entry in legs {
                
                if contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]] == nil {
                    contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]] = [JSON]()
                }
                
                
                contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]]!.append(entry)
                //(entry["last_name"].stringValue+", "+entry["first_name"].stringValue)
                
            }
//            for (letter, list) in contacts {
//                contacts[letter] = list.sorted()
//            }
        }
        legTable.reloadData()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts[letters[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(self.letters[section])
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.letters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //and the content for a specific cell c in section i is:
        //contacts[letters[i]][c]

        let cell = tableView.dequeueReusableCell(withIdentifier: "legCell", for: indexPath)
        if(legs.indices.contains(indexPath.row)) {
            cell.textLabel?.text = (contacts[letters[indexPath.section]]?[indexPath.row]["last_name"].stringValue)!+", "+(contacts[letters[indexPath.section]]?[indexPath.row]["first_name"].stringValue)!
            let state = self.states[(contacts[letters[indexPath.section]]?[indexPath.row]["state"].stringValue)!]
            cell.detailTextLabel?.text = state
//            var filePath = "https://theunitedstates.io/images/congress/original/"+legs[indexPath.row]["]bioguide_id"].stringValue+".jpg"
//            if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
//                cell.contentView.contentMode = .scaleAspectFit
//                cell.contentView.im = image
//            }
         //   cell.imageView? = load_image("https://theunitedstates.io/images/congress/original/"+legs[indexPath.row]["]bioguide_id"]+".jpg")
            
        }
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

