//
//  FirstViewController.swift
//  Congress Search
//
//  Created by Anush on 11/23/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import UIKit
import Alamofire
class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var legTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        var property:String = "sdfsd"
        legTable.delegate = self
        legTable.dataSource = self
            
        
        Alamofire.request("https://2-dot-congress-148223.appspot.com/main.php?action=content").responseJSON { response in
                
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
            
            

        // Do any additional setup after loading the view, typically from a nib.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "legCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = "asdf"
        cell.detailTextLabel?.text = "lol"
        
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

