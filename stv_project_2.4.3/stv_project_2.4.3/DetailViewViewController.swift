//
//  DetailViewViewController.swift
//  stv_project_2.4.3
//
//  Created by 米田大弥 on 2019/01/21.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var forecasts:String?
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = forecasts
        print(forecasts)
        
    }
    
    
    
    
}
