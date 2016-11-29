//
//  MenuController.swift
//  Congress Search
//
//  Created by Anush on 11/29/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
class MenuController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var menuTable: UITableView!
    @IBOutlet var menuImage: UIImageView!
    var menus = ["Legislators", "Bills", "Committee", "Favorite", "About"]

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;

        menuImage.image = UIImage(named:"logo.png")
//        menuImage.image?.scale = CGSize(width: 200, height: 160)
//        menuImage.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        self.menuTable.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text = menus[indexPath.row]
        cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 16)

        return cell
    }
    
}
