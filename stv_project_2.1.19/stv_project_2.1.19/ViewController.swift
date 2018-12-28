//
//  ViewController.swift
//  stv_project_2.1.19
//
//  Created by 米田大弥 on 2018/12/22.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var textField: UITextField!
    
    @IBAction func enter(_ sender: Any) {
        if textField.text != ""{
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondController = segue.destination as? SecondViewController
        secondController?.myString = textField.text ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
