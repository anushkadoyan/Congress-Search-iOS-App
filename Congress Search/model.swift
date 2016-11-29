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
    var jsonObject: [JSON] = []
    var leg = [JSON]()
    var legHouse = [JSON]()
    var legSenate = [JSON]()
//    var leg = [JSON]()

    //$content = array($legislators,$committees,$billsOld,$billsNew,$legislatorsHouse,$legislatorsSenate);

    //0 for legislators
    //1 for committees
    //2 for billsOld
    //3 for billsNew
    //4 for legislatorsHouse
    //5 for legislatorsSenate
    func getLegs(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=legReg"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                let json = JSON(value)["results"]
                self.leg = json.array!
                
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reload, object: nil)
                }
            case .failure(let error):
                print(error)
                
                
            }
        }
    }
        func getLegsHouse(){
            let url = "https://2-dot-congress-148223.appspot.com/main.php?action=legHouse"
            Alamofire.request(url).responseJSON { (Response) -> Void in
                switch Response.result {
                // checking if result has value
                case .success(let value):
                    //                let json = JSON(value)
                    let jsonHouse = JSON(value)["results"]
//                    
//                    for var entry in jsonHouse.array! {
//                        var filePath = entry["bioguide_id"].stringValue+".jpg"
//                        if let url  = NSURL(string: filePath),
//                            let thing = NSData(contentsOf: url as URL){
//                            entry["image"] = thing
//                        }
//                    }
//
                   
                    
                    self.legHouse = jsonHouse.array!

                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .reload, object: nil)
                    }
                case .failure(let error):
                    print(error)
                    
                    
                }
            }
        }

            func getLegsSenate(){
                let url = "https://2-dot-congress-148223.appspot.com/main.php?action=legSenate"
                Alamofire.request(url).responseJSON { (Response) -> Void in
                    switch Response.result {
                    // checking if result has value
                    case .success(let value):
                        //                let json = JSON(value)
                        let jsonSenate = JSON(value)["results"]
                        self.legSenate = jsonSenate.array!
                        
                        
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
