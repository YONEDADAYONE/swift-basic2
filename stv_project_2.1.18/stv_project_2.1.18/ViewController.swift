//
//  ViewController.swift
//  stv_project_2.1.18
//
//  Created by 米田大弥 on 2018/12/23.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func goNextView(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let segue = storyboard.instantiateViewController(withIdentifier: "NewViewController") as? NewViewController
        //アンラップしていた箇所をsegue! から segue ?? UIViewController() に変更
        self.navigationController?.pushViewController(segue ?? UIViewController(), animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}
