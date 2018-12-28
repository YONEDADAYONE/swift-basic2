//
//  SecondViewController.swift
//  stv_project_2.3.1
//
//  Created by 米田大弥 on 2018/12/24.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let random = Int(arc4random_uniform(5))
        
        //Int型のデータを保存、読込
        // intSaveというキーで値「random」を保存する
        userDefaults.set(random, forKey: "intSave")
        let result = userDefaults.integer(forKey: "intSave")
        print(result)
        print(random)
        
        // UserDefaultsへの値の保存を明示的に行う
        userDefaults.synchronize()
        
        // intSaveというキーを指定して保存していた値を取り出す
        if userDefaults.object(forKey: "intSave") != nil {
            print("結果は\(result)です")
        }
    }
    
}
