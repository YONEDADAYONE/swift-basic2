//
//  ViewController.swift
//  stv_project_1.1.3
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let number1 = arc4random_uniform(10)
    let number2 = arc4random_uniform(10)
    let figure: Int = 10
    let names: [String] = ["Suzuki", "Yokoyama", "Tanaka"]
    let tea: String = "EarlGrey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //直す
        checkVariablea()
        peopleName()
        forTest()
        figureTest()
        teaSelect()
    }
    
    //三項演算子を使用
    func checkVariablea() {
        let numberResult = (number1 > number2) ? number1 : number2
        //結果はno2のｈ方が....に訂正
        print("number1は\(number1)、number2は\(number2)、結果は\(numberResult)")
    }
    
    //for文をを使用
    func peopleName() {
        for name in names {
            print("名前は\(name)です")
        }
    }
    
    //if文およびfor文を使用
    func forTest() {
        for index in 3...6 {
            if index >= 4 {
                print("4以上です")
            } else {
                print("4以下です")
            }
        }
    }
    
    //if文およびelse if文を使用
    func figureTest() {
        if figure >= 10 {
            print("10以上です")
        } else if figure <= 10 {
            print("10以下です")
        } else if figure == 10 {
            print("10です")
        } else {
            print("わかりません")
        }
    }
    
    //switch文を使用
    func teaSelect() {
        switch tea {
        case "EarlGrey":
            print("アールグレイです")
        default:
            print("アールグレイデハありません")
        }
    }
}
