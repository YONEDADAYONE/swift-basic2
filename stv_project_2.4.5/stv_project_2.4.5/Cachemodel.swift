//
//  Cachemodel.swift
//  stv_project_2.4.5
//
//  Created by 米田大弥 on 2019/01/27.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation
import UIKit

class Cachemodel {
    
    let imageCache = NSCache<AnyObject, UIImage>()
    
    //ユーザーデフォルツを使用する
    let userDefaults = UserDefaults.standard
    
    var url = URL(string: "")
    
    
    func ccc() {
        
        userDefaults.set(url, forKey: "save20")
        
        //plistファイルへの出力と同期する。
        userDefaults.synchronize()
        
        //内容確認
        if UserDefaults.standard.object(forKey: "save20") != nil {
            print("値はあるよんんん")
            print(userDefaults.string(forKey: "save20") ?? "")
        }
        
    }
    
    

}
