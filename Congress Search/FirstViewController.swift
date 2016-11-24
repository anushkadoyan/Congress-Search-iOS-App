//
//  FirstViewController.swift
//  Congress Search
//
//  Created by Anush on 11/23/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import UIKit
import Alamofire
class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        var property:String = "sdfsd"
        
            
            
            Alamofire.request("https://2-dot-congress-148223.appspot.com/main.php?action=content").responseJSON { response in
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
            }
            
            

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

