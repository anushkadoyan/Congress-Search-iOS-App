//
//  model.swift
//  Congress Search
//
//  Created by Anush on 11/25/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class model {
//    static let fvc = FirstViewController()
    var jsonObject: [JSON] = []
    var a = [JSON]()
    //0 for legislators
    func getJSON(index: Int){
        print("success")

        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=content"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                let json = JSON(value)[index]["results"]
                
            
               
                //                fvc.a = json.array! as [AnyObject]
                //                    let sortedResults = json.sort { $0["distance"].doubleValue < $1["distance"].doubleValue }
                self.a = json.array!
//                for anItem in json.array! {
//        
//                    let title: String? = anItem["last_name"].stringValue + ", " + anItem["first_name"].stringValue
//                    let body: String? = anItem["last_name"].stringValue
//                    model.fvc.tableTitle.append(title!)
//                    model.fvc.tableBody.append(body!)
//
//                }
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reload, object: nil)
                }
            case .failure(let error):
                print(error)
                
                
            }
        }
}
}
