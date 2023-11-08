//
//  AppDelegate.swift
//  ios_notepad
//
//  Created by 吴超 on 2021/7/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var tab: UTabBarController!
    var nav1: UINavigationController?
    
 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        
//        if (Date().timeIntervalSince1970  > 1694099941) {
//            exit(0)
//            return true
//        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        var loginSuccess: String = UserDefaults.standard.string(forKey: String.loginSuccess) ?? ""
        if loginSuccess.count == 3 {
            tab = UTabBarController()
            window?.rootViewController = tab
        }else{
            let nav = UINavigationController(rootViewController: LoginVC())
            window?.rootViewController = nav
            nav1 = nav
        }
 
        window?.makeKeyAndVisible()
        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -60), for: .default)
 
        
        return true
    }

    

}
 
