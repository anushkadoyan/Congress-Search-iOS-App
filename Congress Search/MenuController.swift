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
    var mainViewController: UIViewController!
    var aboutController: UIViewController!
    var billTabBarController: UIViewController!
    var commTabBarController: UIViewController!
    var favTabBarController: UIViewController!


//    var javaViewController: UIViewController!
//    var goViewController: UIViewController!
//    var nonMenuViewController: UIViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.modalPresentationStyle = UIModalPresentationCurrentContext;

        menuImage.image = UIImage(named:"logo.png")
//        menuImage.image?.scale = CGSize(width: 200, height: 160)
//        menuImage.frame = CGRect(x: 0, y: 0, width: 200, height: 160)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        self.menuTable.separatorColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LegTabBarController") as! LegTabBarController
        self.mainViewController = mainViewController

        let aboutController = storyboard.instantiateViewController(withIdentifier: "AboutController") as! AboutController
        self.aboutController = aboutController
        let billTabBarController = storyboard.instantiateViewController(withIdentifier: "BillTabBarController") as! BillTabBarController
        self.billTabBarController = billTabBarController
        let commTabBarController = storyboard.instantiateViewController(withIdentifier: "CommTabBarController") as! CommTabBarController
        self.commTabBarController = commTabBarController
        let favTabBarController = storyboard.instantiateViewController(withIdentifier: "FavTabBarController") as! FavTabBarController
        self.favTabBarController = favTabBarController


    }
    
    
    func changeViewController(_ thing: Int) {
        if (thing == 0) {
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        }
        else if(thing==1) {
            self.slideMenuController()?.changeMainViewController(self.billTabBarController, close: true)
        }
        //            self.slideMenuController()?.changeMainViewController(self.swiftViewController, close: true)
        else if(thing==2) {
            self.slideMenuController()?.changeMainViewController(self.commTabBarController  , close: true)
        }
        else if(thing==3) {
            self.slideMenuController()?.changeMainViewController(self.favTabBarController  , close: true)
        }
        if(thing == 4) {
            self.slideMenuController()?.changeMainViewController(self.aboutController, close: true)
        }
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let menu = LeftMenu(rawValue: indexPath.row) {
            self.changeViewController(indexPath.row)
//        }
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
