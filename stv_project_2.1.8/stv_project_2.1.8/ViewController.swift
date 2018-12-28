//
//  ViewController.swift
//  stv_project_2.1.8
//
//  Created by 米田大弥 on 2018/12/19.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet private weak var selectLabel: UILabel!
    @IBOutlet private weak var pickerView: UIPickerView!
    @IBOutlet private weak var toolBar: UIToolbar!
    
    let dataList = ["いちご", "メロン", "バナナ", "ばなな", "ぶどう", "マスカット"]
    
    @IBAction func labelTap(_ sender: UITapGestureRecognizer) {
        pickerView.isHidden = false
        toolBar.isHidden = false
    }
    
    @IBAction func itemTap(_ sender: UIBarButtonItem) {
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        selectLabel.text = dataList[row]
        
    }
    
    //背景をタップしたらキーボードが閉じるメソッド
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        pickerView.isHidden = true
        toolBar.isHidden = true
    }
    
}
