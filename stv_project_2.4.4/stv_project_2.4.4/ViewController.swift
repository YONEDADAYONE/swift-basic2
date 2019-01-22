//
//  ViewController.swift
//  stv_project_2.4.4
//
//  Created by 米田大弥 on 2019/01/10.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var forecasts = [ForecastList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Forecaster.forecast { result in
            self.forecasts = result.forecasts
            
            print(self.forecasts)
            
        }
        
    }
    

    
}

