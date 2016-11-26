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
    func getOrders(completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        makeCall(completionHandler: completionHandler)
    }
    
    func makeCall(completionHandler: @escaping (NSDictionary?, NSError?) -> ()) {
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=content"
        Alamofire.request( url)
            .responseJSON { response in
                switch response.result {
                    case .success(let value):
                        completionHandler(value as? NSDictionary, nil)
                    case .failure(let error):
                        completionHandler(nil, error as NSError?)
                }
        }
    }
//    func getData() {
//        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=content"
//        Alamofire.request(url).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)[0]["results"]
//                print("JSON: \(json)")
//                var lol = json
//                if let items = json.array {
//                    for item in items {
//                        if let title = item["first_name"].string {
//                            print(title)
//                            //                            self.numLegs = self.numLegs+1
//                        }
//                    }
//                }
////                return lol
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//

}   
