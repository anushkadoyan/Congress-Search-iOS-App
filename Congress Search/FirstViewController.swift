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
    let mod = model()

    override func viewDidLoad() {
        super.viewDidLoad()
        legTable.delegate = self
        legTable.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableData(_:)), name: .reload, object: nil)
        self.mod.getJSON(index:0)
            // Do any additional setup after loading the view, typically from a nib.
    }
    func reloadTableData(_ notification: Notification) {
        print("reload")
        legTable.reloadData()
    }

    convenience init() {
        self.init(nibName:nil, bundle:nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 538
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "legCell", for: indexPath)
        if(self.mod.a.indices.contains(indexPath.row)) {
            cell.textLabel?.text = self.mod.a[indexPath.row]["last_name"].stringValue + ", " + self.mod.a[indexPath.row]["first_name"].stringValue
            cell.detailTextLabel?.text = self.mod.a[indexPath.row]["state"].stringValue
//            var filePath = "https://theunitedstates.io/images/congress/original/"+self.mod.a[indexPath.row]["]bioguide_id"].stringValue+".jpg"
//            if let filePath = Bundle.main.path(forResource: "imageName", ofType: "jpg"), let image = UIImage(contentsOfFile: filePath) {
//                cell.contentView.contentMode = .scaleAspectFit
//                cell.contentView.im = image
//            }
         //   cell.imageView? = load_image("https://theunitedstates.io/images/congress/original/"+self.mod.a[indexPath.row]["]bioguide_id"]+".jpg")
            
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

