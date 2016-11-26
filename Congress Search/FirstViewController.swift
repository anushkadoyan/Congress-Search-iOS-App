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
//    var someInts = [Object]()
//    var numLegs = 0
    var lol = JSON("")
    
    var tableTitle = [String]()
    var tableBody = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        legTable.delegate = self
        legTable.dataSource = self

        getJSON()
            // Do any additional setup after loading the view, typically from a nib.
    }
    func getJSON(){
         let url = "https://2-dot-congress-148223.appspot.com/main.php?action=content"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
                case .success(let value):
                
                    let json = JSON(value)[0]["results"]
//                    let sortedResults = json.sort { $0["distance"].doubleValue < $1["distance"].doubleValue }

                    for anItem in json.array! {

                        let title: String? = anItem["last_name"].stringValue + ", " + anItem["first_name"].stringValue
                        let body: String? = anItem["last_name"].stringValue
                        self.tableTitle.append(title!)
                        self.tableBody.append(body!)
                    }
                case .failure(let error):
                    print(error)

                DispatchQueue.main.async {
                    self.legTable.reloadData()
                }
                
            }
            
        }
        
    }
    func convertStringToDictionary(text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 538
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "legCell", for: indexPath)
        if(tableTitle.indices.contains(indexPath.row)) {
            cell.textLabel?.text = tableTitle[indexPath.row]
            cell.detailTextLabel?.text = "lol"
        }
//        print(tableTitle[indexPath.row])
//        cell.detailTextLabel?.body!.text = tableBody[indexPath.row]
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
//            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
////        print(indexPath.row)
////        print(self.lol[0]["first_name"])
//        cell.textLabel?.text = "lol"
//            //self.lol["first_name"].stringValue
//        cell.detailTextLabel?.text = "lol"
//        
//        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

