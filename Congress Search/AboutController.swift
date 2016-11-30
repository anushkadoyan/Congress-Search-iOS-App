//
//  About.swift
//  Congress Search
//
//  Created by Anush on 11/29/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
class AboutController: UIViewController {
    @IBOutlet var pic: UIImageView!
    
    @IBOutlet var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        pic.image = UIImage(named: "idpic.jpeg")
    }
    
    @IBAction func menuButtonPressed(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
}
