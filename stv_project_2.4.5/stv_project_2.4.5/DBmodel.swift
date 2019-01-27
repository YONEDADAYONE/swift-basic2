//
//  DBmodel.swift
//  stv_project_2.4.5
//
//  Created by 米田大弥 on 2019/01/25.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class Storage {
    
    //ユーザーデフォルツを使用する
    let userDefaults = UserDefaults.standard
    
    var weatherDate = ""
    var weatherDatelabel = ""
    var weatherTelop = ""
    var weatherImageurl = ""
    
    
    func ddd() {
        
    userDefaults.set(weatherDate, forKey: "save10")
    userDefaults.set(weatherDatelabel, forKey: "save11")
    userDefaults.set(weatherTelop, forKey: "save12")
    userDefaults.set(weatherImageurl, forKey: "save13")
        
    //plistファイルへの出力と同期する。
    userDefaults.synchronize()
        
        //内容確認
    if UserDefaults.standard.object(forKey: "save10") != nil {
            print("値はあるよん")
            print(userDefaults.string(forKey: "save10") ?? "")
        }
    }
}
