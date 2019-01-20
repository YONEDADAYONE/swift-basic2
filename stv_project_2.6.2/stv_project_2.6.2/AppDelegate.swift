//
//  AppDelegate.swift
//  stv_project_2.6.2
//
//  Created by 米田大弥 on 2019/01/17.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
                print("url : \(url.absoluteString)")
        print("scheme : \(url.scheme ?? "")")
        print("host : \(url.host ?? "")")
        print("port : \(url.port ?? 0)")
        print("query : \(url.query ?? "")")
        
        //vcの中に検索フォームに入力された値を入れます。
        let goVc = window?.rootViewController as? ViewController
        
        //NSURLをStringに変換します。vc.urlabel.textにはoptional型の文字列が入っています。・
        goVc?.urlabel.text = url.absoluteString
        
        print(goVc?.urlabel.text ?? "")
    
        // 一例で「あいう」と入力したら「xn--l8jeg」とでるのでそれを元の日本語に戻します。
//        var a:String = url.absoluteString
        
        return true
    }

}
