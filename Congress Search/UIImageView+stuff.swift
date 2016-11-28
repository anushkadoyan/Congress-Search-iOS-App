//
//  UIImageView+stuff.swift
//  Congress Search
//
//  Created by Anush on 11/27/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
                NotificationCenter.default.post(name: .reloadAgain, object: nil)

            }
        }).resume()
    }
}
