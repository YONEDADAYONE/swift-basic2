//
//  ViewController.swift
//  stv_project_2.1.17
//
//  Created by 米田大弥 on 2018/12/24.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onClickMyButton(sender: UIButton) {
//        // 遷移するViewを定義する。
//        let secondViewController: SecondViewController =
//            self.storyboard?.instantiateViewController(withIdentifier: "segue")
//                as? SecondViewController ?? SecondViewController()
//        // Viewの移動する.
//        self.present(secondViewController, animated: true, completion: nil)
        
        let secondViewController: SecondViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "segue")
                as? SecondViewController ?? SecondViewController()
        
        self.present(secondViewController, animated: true, completion: nil)
        
    }
    
}
