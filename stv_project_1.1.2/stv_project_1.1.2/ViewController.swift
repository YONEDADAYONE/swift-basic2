//
//  ViewController.swift
//  stv_project_1.1.2
//
//  Created by 米田大弥 on 2018/12/15.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let user = ["name": "Yoneda"]

    var number: Int? = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callName()
        callNumber()
        callChange()
    }
    
    //Optional Bindingを使用
    func callName() {
        if let user = user["name"] {
            print(user)
        }
    }
    
    //Nil Coalescing Operatorを使用
    func callNumber() {
        let result = number ?? 5
        print(result)
    }
    //Optional Chainingを使用
    func callChange() {
        let change = "Optional Chaining"
        print(change as Any)
    }
}
