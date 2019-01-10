//
//  ViewController.swift
//  stv_project_2.4.2
//
//  Created by 米田大弥 on 2019/01/04.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var forecasts = [ForecastList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Forecaster.forecast { result in
            self.forecasts = result.forecasts
            print(self.forecasts)
        }
        
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        let alert: UIAlertController =
            UIAlertController(title: "天気です",
                              message: "どのデータを閲覧しますか？",
                              preferredStyle: UIAlertController.Style.actionSheet)
        
        let facebookActionsheet: UIAlertAction =
            UIAlertAction(title: "本日",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
                            print(self.forecasts[0])
            })
        
        let twitterActionsheet: UIAlertAction =
            UIAlertAction(title: "明日",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
                            print(self.forecasts[1])
            })
        
        let lineActionsheet: UIAlertAction =
            UIAlertAction(title: "明後日",
                          style: UIAlertAction.Style.default,
                          handler: {(_: UIAlertAction) in
                            print(self.forecasts[2])
            })
        
        alert.addAction(facebookActionsheet)
        alert.addAction(twitterActionsheet)
        alert.addAction(lineActionsheet)
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    }
