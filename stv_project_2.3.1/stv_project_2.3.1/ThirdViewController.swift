//
//  ThirdViewController.swift
//  stv_project_2.3.1
//
//  Created by 米田大弥 on 2018/12/24.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random = Double.random(in: 0.0...1.0)
        
        //Int型のデータを保存、読込
        // intSaveというキーで値「random」を保存する
        userDefaults.set(random, forKey: "doubleSave")
        let result = userDefaults.integer(forKey: "doubleSave")
        print(result)
        
        // UserDefaultsへの値の保存を明示的に行う
        userDefaults.synchronize()
        
        // intSaveというキーを指定して保存していた値を取り出す
        if userDefaults.object(forKey: "doubleSave") != nil {
            print("結果は\(result)です")
        }
    }
    
}
