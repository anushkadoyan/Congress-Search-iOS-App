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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pic.image = UIImage(named: "idpic.jpeg")
    }
    
}
