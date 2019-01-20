//
//  AppDelegate.swift
//  stv_project_2.5.9
//
//  Created by 米田大弥 on 2019/01/18.
//  Copyright © 2019 hiroya. All rights reserved.
//
import UserNotifications
//import NotificationCenter
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // プッシュ通知登録
//        let apnsTypes: UIUserNotificationType = [.badge, .sound, .alert]
//        let notiSettings = UIUserNotificationSettings(types: apnsTypes, categories: nil)
//        application.registerUserNotificationSettings(notiSettings)
//        application.registerForRemoteNotifications()
        
        //https://qiita.com/mshrwtnb/items/3135e931eedc97479bb5 を参考
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .sound, .alert]) { granted, error in
                if error != nil {
                    // エラー
                    return
                }
                
                if granted {
                    // 通知許可された
                } else {
                    // 通知拒否
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        
        return true
    }
    
    // プッシュ通知登録成功時のデバイストークン取得処理
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenText = deviceToken.map { String(format: "%.2hhx", $0) }.joined()
        print("deviceToken = \(tokenText)")
    }
    
    // プッシュ通知登録失敗時
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to get token, error: \(error)")
    }
    
    // 通知取得時処理
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}
