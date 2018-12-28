//
//  ViewController.swift
//  stv_project_2.1.9
//
//  Created by 米田大弥 on 2018/12/22.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var label: UILabel!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var toolBar: UIToolbar!
    
    @IBAction func tapLabel(_ sender: UITapGestureRecognizer) {
        datePicker.isHidden = false
        toolBar.isHidden = false
    }
    
    @IBAction func tapBarButton(_ sender: UIBarButtonItem) {
        datePicker.isHidden = true
        toolBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.isHidden = true
        toolBar.isHidden = true
        getCurrentDateTime()
    }

    @IBAction func selectedDatePicker(_ sender: UIDatePicker) {
        
        let dfm = DateFormatter()
        
        dfm.dateFormat = "yyyy-MM-dd"
        dfm.locale = Locale(identifier: "ja_JP")
        
        print(dfm.string(from: sender.date))
        
        label.text = dfm.string(from: sender.date)
        dfm.dateStyle = .medium
        dfm.timeStyle = .none
        dfm.doesRelativeDateFormatting = true
        
        label.text = dfm.string(from: sender.date)
        
    }
    
    //背景をタップしたらキーボードが閉じるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        datePicker.isHidden = true
        toolBar.isHidden = true
    }

    //初期画面で今日の日付をに表示する、メソッド
    func getCurrentDateTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ja_JP")
        let str2 = formatter.string(from: Date())
        label.text = str2
    }
    
}
