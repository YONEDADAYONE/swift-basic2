//
//  ViewController.swift
//  stv_project_1.1.4
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let manUser: Account = Account(name: "太郎", language: "swift", gender: "男", age: 25)
    let womanUser: Account = Account(name: "花子", language: "java", gender: "女", age: 19)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkGender()
    }
    
        func checkGender() {
        manUser.result()
        womanUser.result2()
        }
    
}
