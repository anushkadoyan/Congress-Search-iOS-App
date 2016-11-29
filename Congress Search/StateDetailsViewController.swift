//
//  StateDetailsViewController.swift
//  Congress Search
//
//  Created by Anush on 11/28/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit
class StateDetailsViewController: UIViewController
//, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //self.dismissViewControllerAnimated(true, completion: nil)

}
