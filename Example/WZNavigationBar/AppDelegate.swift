//
//  AppDelegate.swift
//  WZNavigationBar
//
//  Created by LiuSky on 12/03/2019.
//  Copyright (c) 2019 LiuSky. All rights reserved.
//

import UIKit
import WZNavigationBar

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let nav = UINavigationController(rootViewController: ViewController())
        
        // 统一配置
        nav.navigation.configuration.isEnabled = true
        nav.navigation.configuration.isShadowHidden = true
        nav.navigation.configuration.setBackgroundImage(UIImage(color: UIColor.red, size: CGSize(width: 1, height: 1)))
        nav.navigation.configuration.tintColor = UIColor.white
        nav.navigation.configuration.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.navigation.configuration.statusBarStyle = .lightContent
        if #available(iOS 11.0, *) {
            nav.navigation.prefersLargeTitles()
        }
        nav.navigation.configuration.backItem = Configuration.BackItem(style: BackBarButtonItem.ItemStyle.image(UIImage(named: "navigation_back_default1")))
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


// MARK: - Initializers
public extension UIImage {
    
    // 创建图像来自颜色和大小
    //
    // - Parameters:
    //   - color: 颜色
    //   - size: 大小
    convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
}

