//
//  AppDelegate.swift
//  Congress Search
//
//  Created by Anush on 11/23/16.
//  Copyright © 2016 Anush Kadoyan. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import SwiftyJSON
var favorites = [String: [JSON]]()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
//    let mod = model()
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let appearance = UITabBarItem.appearance()
        let attributes = [NSFontAttributeName:UIFont(name: "Arial", size: 20)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
        
        favorites["legs"] = [JSON]()
        favorites["bills"] = [JSON]()
        favorites["comms"] = [JSON]()

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LegTabBarController") as! LegTabBarController
//        let mainViewController = storyboard.instantiateViewController(withIdentifier: "LegTabBarController") as! LegTabBarController


        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftMenu") as! LeftMenu
        let slideMenuController = SlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()

//        let mainViewController =  storyboard.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
//        let slideMenuController = SlideMenuController(mainViewController: (LegTabBarController as? UITabBarController)!, leftMenuViewController: (LeftMenu as? UIViewController)!)
//        self.window?.rootViewController = slideMenuController
//        self.window?.makeKeyAndVisible(
        
        
//        self.mod.getJSON()
        return true
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

