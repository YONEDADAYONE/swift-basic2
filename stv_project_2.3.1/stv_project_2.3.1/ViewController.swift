//
//  ViewController.swift
//  stv_project_2.3.1
//
//  Created by 米田大弥 on 2018/12/24.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak private var testLabel: UILabel!
    @IBOutlet weak private var testTextField: UITextField!
    
    let userDefaults = UserDefaults.standard
    
    //最初からあるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //デリゲート先を自分に設定する
        testTextField.delegate = self
        
        //文字列が保存されている場合はラベルに文字列を設定する。
        
        if let labelText = userDefaults.string(forKey: "labelText") {
            testLabel.text = labelText
        }
        
    }
    
    //Returnキー押下時の呼び出しメソッド
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードをしまう
        testTextField.resignFirstResponder()
        
        //テキストフィールドの文字列をラベルに設定する。
        testLabel.text = testTextField.text
        
        //ラベルの文字列を保存する。
        userDefaults.set(testLabel.text, forKey: "labelText")
        
        //plistファイルへの出力と同期する。
        userDefaults.synchronize()
        
        return true
    }
    
}
