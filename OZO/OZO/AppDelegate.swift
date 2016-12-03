//
//  AppDelegate.swift
//  MySecond
//
//  Created by lixs on 2016/11/24.
//  Copyright © 2016年 . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //导航栏背景颜色
        UINavigationBar.appearance().barTintColor = KBackGroundColor
        //导航栏标题字颜色
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName:kYColor]
        
        
        /**状态栏字体颜色
         第一种
         在相应控制器中
         override func preferredStatusBarStyle() -> UIStatusBarStyle {
         
         return UIStatusBarStyle.LightContent;
         
         }
         第二种
         全局设置
         在Info.plist中设置UIViewControllerBasedStatusBarAppearance 为NO
         UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
         */
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent;
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.backgroundColor = UIColor.white
        
        let userutils = UserUtils();
        //判断是否登录
        if(!userutils.getUserId().isEmpty){
            window?.rootViewController = UINavigationController(rootViewController : MainController(nibName:nil,bundle: nil));
        }else{
            window?.rootViewController = UINavigationController(rootViewController:LoginController(nibName:nil,bundle: nil));
        }
        
        window?.makeKeyAndVisible()
        
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

