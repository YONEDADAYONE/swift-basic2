//
//  ViewController.swift
//  stv_project_2.1.1
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var myLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myLabel.text = NSLocalizedString("test", comment: "")
    }
    
}
