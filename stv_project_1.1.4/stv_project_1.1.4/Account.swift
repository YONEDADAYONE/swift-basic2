//
//  Account.swift
//  stv_project_1.1.4
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class Account {
    
    var name: String
    let language: String
    let gender: String
    let age: Int
    
    // 初期化時に呼ばれる
    init(name: String, language: String, gender: String, age: Int) {
        self.name = name // 引数の変数名とクラスのプロパティを区別するため、selfをつける
        self.language = language // 定数もinitの中なら設定できる
        self.gender = gender
        self.age = age
        
    }
    
    func result() {
        print("\(gender)の場合、「\(name)君は\(language)が得意な\(age)歳です。」")
    }
    
    func result2() {
        print("\(gender)の場合、「\(name)さんは\(language)が得意な\(age)歳です。」")
    }
    
}
