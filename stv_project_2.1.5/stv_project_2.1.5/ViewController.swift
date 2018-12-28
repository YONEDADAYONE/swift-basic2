//
//  ViewController.swift
//  stv_project_2.1.5
//
//  Created by 米田大弥 on 2018/12/21.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapButton(_ sender: UIButton) {
        
        let alert: UIAlertController =
            UIAlertController(title: "SNS三社です。",
                              message: "どれにしますか？",
                              preferredStyle: UIAlertController.Style.actionSheet)
        
        let facebookActionsheet: UIAlertAction =
            UIAlertAction(title: "Facebook",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
            print("Facebook")
        })
        
        let twitterActionsheet: UIAlertAction =
            UIAlertAction(title: "Twitter",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
            print("Twitter")
        })
        
        let lineActionsheet: UIAlertAction =
            UIAlertAction(title: "LINE",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
            print("LINE")
        })
        
        alert.addAction(facebookActionsheet)
        alert.addAction(twitterActionsheet)
        alert.addAction(lineActionsheet)
        
        self.present(alert, animated: true, completion: nil)
        
    }

}
