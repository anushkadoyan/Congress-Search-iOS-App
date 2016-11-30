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
    var activeBills = [JSON]()
    var newBills = [JSON]()
    var houseComms = [JSON]()
    var senateComms = [JSON]()
    var jointComms = [JSON]()


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
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .reload, object: nil)
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    func getActiveBills(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=billsOld"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                //                let json = JSON(value)
                let jsonSenate = JSON(value)["results"]
                self.activeBills = jsonSenate.array!
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reloadActiveBills, object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getNewBills(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=billsNew"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                //                let json = JSON(value)
                let jsonSenate = JSON(value)["results"]
                self.newBills = jsonSenate.array!
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reloadNewBills, object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getHouseComms(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=houseComms"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                //                let json = JSON(value)
                let jsonSenate = JSON(value)["results"]
                self.houseComms = jsonSenate.array!
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reloadHouseComms, object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getSenateComms(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=senateComms"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                //                let json = JSON(value)
                let jsonSenate = JSON(value)["results"]
                self.senateComms = jsonSenate.array!
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reloadSenateComms, object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func getJointComms(){
        let url = "https://2-dot-congress-148223.appspot.com/main.php?action=jointComms"
        Alamofire.request(url).responseJSON { (Response) -> Void in
            switch Response.result {
            // checking if result has value
            case .success(let value):
                //                let json = JSON(value)
                let jsonSenate = JSON(value)["results"]
                self.jointComms = jsonSenate.array!
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .reloadJointComms, object: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }



}
