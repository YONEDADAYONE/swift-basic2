//
//  SecondViewController.swift
//  stv_project_2.1.19
//
//  Created by 米田大弥 on 2018/12/22.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    var myString = String()
    @IBOutlet private weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = myString
    }

}
