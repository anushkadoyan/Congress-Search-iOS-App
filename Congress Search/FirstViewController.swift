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
import SwiftSpinner
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var MenuButton: UIBarButtonItem!
    @IBOutlet weak var legTable: UITableView!
    var legs = [JSON]()
    let mod = model()

    var letters: [Character] = []
    var lettersInString: [String] = []
    var data: [String] = []
    var nameData: [String] = []

    var contacts = [Character: [JSON]]()
    
     var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (self.legs.count==0) {
            SwiftSpinner.show("Loading...")
        }
        legTable.delegate = self
        legTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(reloadData(_:)), name: .reloadAgain, object: nil)

        self.mod.getLegs()
    }
    
    
    
    @IBAction func MenuButtonClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    func reloadData(_ notification: Notification) {
        legTable.reloadData()
    }
    func reloadTableData(_ notification: Notification) {
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
            lettersInString = Array(letters).map { String($0) }

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

        }
        legTable.reloadData()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersInString
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
               let cell = tableView.dequeueReusableCell(withIdentifier: "legCell", for: indexPath)
               if(legs.indices.contains(indexPath.row)) {
                SwiftSpinner.hide()
            cell.textLabel?.text = (contacts[letters[indexPath.section]]?[indexPath.row]["last_name"].stringValue)!+", "+(contacts[letters[indexPath.section]]?[indexPath.row]["first_name"].stringValue)!
            let state = self.states[(contacts[letters[indexPath.section]]?[indexPath.row]["state"].stringValue)!]
            cell.detailTextLabel?.text = state
            let filePath = "https://theunitedstates.io/images/congress/original/"+(contacts[letters[indexPath.section]]?[indexPath.row]["bioguide_id"].stringValue)!+".jpg"

            //(contacts[letters[indexPath.section]]?[indexPath.row]
            cell.imageView?.image = UIImage(named: "placeholder.jpg")

            cell.imageView?.downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
            cell.imageView?.clipsToBounds = true
//                performSegue(withIdentifier: "stateSeg", sender: nil)

        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "stateSeg", sender: indexPath.row)
    }
        // pass any object as parameter, i.e. the tapped row
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stateSeg",
                let nextScene = segue.destination as? StateDetailsViewController ,
                let indexPath = self.legTable.indexPathForSelectedRow {
                let selectedLeg = contacts[letters[indexPath.section]]?[indexPath.row]
                nextScene.leg = selectedLeg!
            
            }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

