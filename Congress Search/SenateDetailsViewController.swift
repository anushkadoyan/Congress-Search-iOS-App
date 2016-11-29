//
//  StateDetailsViewController.swift
//  Congress Search
//
//  Created by Anush on 11/28/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
class SenateDetailsViewController: UIViewController
    //, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var detailImage: UIImageView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    var leg = JSON("")

    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let filePath = "https://theunitedstates.io/images/congress/original/"+self.leg["bioguide_id"].stringValue+".jpg"
        self.detailImage.downloadImageFrom(link: filePath, contentMode: UIViewContentMode.scaleAspectFit)
    }
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //self.dismissViewControllerAnimated(true, completion: nil)
    
}
