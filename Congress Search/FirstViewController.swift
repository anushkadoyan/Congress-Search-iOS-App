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
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate  {
    

    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var MenuButton: UIBarButtonItem!
    @IBOutlet weak var legTable: UITableView!
    var legs = [JSON]()
    var filteredLegs = [JSON]()
    let mod = model()
    var searchState = String()
    var letters: [Character] = []
    var lettersInString: [String] = []
    var data: [String] = []
    var nameData: [String] = []
    var filtered = 0
    
    var contacts = [Character: [JSON]]()
    var fullStates = ["All States","Alabama", "Alaska", "American Samoa", "Arizona", "Arkansas", "California", "Colorado", "Connecticut", "Delaware", "District Of Columbia", "Federated States Of Micronesia", "Florida", "Georgia", "Guam", "Hawaii", "Idaho", "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Marshall Islands", "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico", "New York", "North Carolina", "North Dakota", "Northern Mariana Islands", "Ohio", "Oklahoma", "Oregon", "Palau", "Pennsylvania", "Puerto Rico", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah", "Vermont", "Virgin Islands", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"];
     var states = [     "AL": "Alabama",     "AK": "Alaska",     "AS": "American Samoa",     "AZ": "Arizona",     "AR": "Arkansas",     "CA": "California",     "CO": "Colorado",     "CT": "Connecticut",     "DE": "Delaware",     "DC": "District Of Columbia",    "FL": "Florida",     "GA": "Georgia",     "GU": "Guam",     "HI": "Hawaii",     "ID": "Idaho",     "IL": "Illinois",     "IN": "Indiana",     "IA": "Iowa",     "KS": "Kansas",     "KY": "Kentucky",     "LA": "Louisiana",     "ME": "Maine",     "MH": "Marshall Islands",     "MD": "Maryland",     "MA": "Massachusetts",     "MI": "Michigan",     "MN": "Minnesota",     "MS": "Mississippi",     "MO": "Missouri",     "MT": "Montana",     "NE": "Nebraska",     "NV": "Nevada",     "NH": "New Hampshire",     "NJ": "New Jersey",     "NM": "New Mexico",     "NY": "New York",     "NC": "North Carolina",     "ND": "North Dakota",     "MP": "Northern Mariana Islands",     "OH": "Ohio",     "OK": "Oklahoma",     "OR": "Oregon",     "PW": "Palau",     "PA": "Pennsylvania",     "PR": "Puerto Rico",     "RI": "Rhode Island",     "SC": "South Carolina",     "SD": "South Dakota",     "TN": "Tennessee",     "TX": "Texas",     "UT": "Utah",     "VT": "Vermont",     "VI": "Virgin Islands",     "VA": "Virginia",     "WA": "Washington",     "WV": "West Virginia",     "WI": "Wisconsin",     "WY": "Wyoming" ];
    var statesFlipped = [
    "Alabama": "AL",
    "Alaska": "AK",
    "American Samoa": "AS",
    "Arizona": "AZ",
    "Arkansas": "AR",
    "California": "CA",
    "Colorado": "CO",
    "Connecticut": "CT",
    "Delaware": "DE",
    "District Of Columbia": "DC",
    "Federated States Of Micronesia": "FM",
    "Florida": "FL",
    "Georgia": "GA",
    "Guam": "GU",
    "Hawaii": "HI",
    "Idaho": "ID",
    "Illinois": "IL",
    "Indiana": "IN",
    "Iowa": "IA",
    "Kansas": "KS",
    "Kentucky": "KY",
    "Louisiana": "LA",
    "Maine": "ME",
    "Marshall Islands": "MH",
    "Maryland": "MD",
    "Massachusetts": "MA",
    "Michigan": "MI",
    "Minnesota": "MN",
    "Mississippi": "MS",
    "Missouri": "MO",
    "Montana": "MT",
    "Nebraska": "NE",
    "Nevada": "NV",
    "New Hampshire": "NH",
    "New Jersey": "NJ",
    "New Mexico": "NM",
    "New York": "NY",
    "North Carolina": "NC",
    "North Dakota": "ND",
    "Northern Mariana Islands": "MP",
    "Ohio": "OH",
    "Oklahoma": "OK",
    "Oregon": "OR",
    "Palau": "PW",
    "Pennsylvania": "PA",
    "Puerto Rico": "PR",
    "Rhode Island": "RI",
    "South Carolina": "SC",
    "South Dakota": "SD",
    "Tennessee": "TN",
    "Texas": "TX",
    "Utah": "UT",
    "Vermont": "VT",
    "Virgin Islands": "VI",
    "Virginia": "VA",
    "Washington": "WA",
    "West Virginia": "WV",
    "Wisconsin": "WI",
    "Wyoming": "WY"
    ]
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
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
  
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fullStates.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent: Int) -> String? {
        return fullStates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent: Int) {
//        print(fullStates[row]);
        if(fullStates[row] != "All States") {
            self.searchState = self.statesFlipped[fullStates[row]]!;
            self.legs = self.mod.leg

            self.legs = self.legs.filter { $0["state"].stringValue == self.searchState} // This will eliminate items with id == "1".
            self.filtered = 1;
            
            NotificationCenter.default.post(name: .reload, object: nil)
        }
        else {
            
            self.filtered = 0;
            NotificationCenter.default.post(name: .reload, object: nil)

        }
       
//        myLabel.text = fullStates[row]
    }
    
    @IBAction func MenuButtonClicked(_ sender: Any) {
        self.slideMenuController()?.openLeft()

    }
    @IBAction func filterClicked(_ sender: Any) {
        if(self.pickerView.isHidden == true) {
//            print("hidden");
            self.pickerView.isHidden = false;
            self.legTable.isHidden = true;
        }
        else {
            self.pickerView.isHidden = true;
            self.legTable.isHidden = false;

        }
    }
    func reloadData(_ notification: Notification) {
        legTable.reloadData()
    }
    func reloadTableData(_ notification: Notification) {
        contacts.removeAll()
        data.removeAll()
        print(self.filtered);

        if(self.filtered == 0) {
            legs = self.mod.leg
        }
        if(self.legs.count>0) {
            for item in self.legs {
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

            for item in self.legs {
                nameData.append(item["last_name"].stringValue+", "+item["first_name"].stringValue)
            }
            for entry in self.legs {
                print(entry)
                if contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]] == nil {
                    contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]] = [JSON]()
                }
                
                
                contacts[entry["state"].stringValue[entry["state"].stringValue.startIndex]]!.append(entry)
                //(entry["last_name"].stringValue+", "+entry["first_name"].stringValue)
            }

        }
//        print(self.contacts)
        legTable.reloadData()
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return lettersInString
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(contacts.count>0) {
            return self.contacts[letters[section]]!.count
        }
        return 538
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

