//
//  AppDelegate.swift
//  Clubhub
//
//  Created by Nicholas Baldini on 1/11/18.
//  Copyright © 2018 Nicholas Baldini. All rights reserved.
//

import UIKit
import GoogleMaps
import IQKeyboardManagerSwift

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Keyboard help
        IQKeyboardManager.sharedManager().enable = true
        
        // Set navigation bar tint / background colour
        
        //NaviBar tint color
        let navibar = UINavigationBar.appearance()
        navibar.barTintColor = UIColor(red: 0, green: 0, blue: 63)
        
        
        navibar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navibar.tintColor = UIColor.white
        
        //Change Status Bar to Light to see on Dark Background
        UIApplication.shared.statusBarStyle = .lightContent

        
        // Set navigation bar ItemButton tint colour
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        // Set Navigation bar background image
        //let navBgImage:UIImage = UIImage(named: "bg_blog_navbar_reduced.jpg")!
        //UINavigationBar.appearance().setBackgroundImage(navBgImage, for: .default)
        
        //Set navigation bar Back button tint colour
        //UINavigationBar.appearance().tintColor = UIColor.white
        GMSServices.provideAPIKey("AIzaSyANuDb9z_E4kGQYaFOvIM-s5cAW03qmICY")
        // Override point for customization after application launch.
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

}
