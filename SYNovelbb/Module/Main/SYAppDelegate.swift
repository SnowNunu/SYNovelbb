//
//  SYAppDelegate.swift
//  SYNovelbb
//
//  Created by Mandora on 2020/7/22.
//  Copyright © 2020 Mandora. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class SYAppDelegate: UIResponder, UIApplicationDelegate, WXApiDelegate {
    
    var window: UIWindow?
    
    var timer: DispatchSourceTimer!
    
    let disposeBag = DisposeBag()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupLog()
        setupRealm()
        setupStoreKit()
        setupShareSDK()
        setupJPush(launchOptions)
        
        window = UIWindow(frame :UIScreen.main.bounds)
        window!.backgroundColor = UIColor.white
        window?.rootViewController = R.storyboard.main().instantiateInitialViewController()!
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    func onReq(_ req: BaseReq) {
        print(req)
    }
    
    func onResp(_ resp: BaseResp) {
        print(resp)
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

