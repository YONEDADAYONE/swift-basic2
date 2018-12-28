//
//  ViewController.swift
//  stv_project_2.1.3
//
//  Created by 米田大弥 on 2018/12/17.
//  Copyright © 2018年 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let image01 = #imageLiteral(resourceName: "hanzai_kids_yukai")
    let image02 = #imageLiteral(resourceName: "megane_sagasu_odeko_woman")
    let image03 = #imageLiteral(resourceName: "money_maizoukin_horu_businessman")
    let image04 = #imageLiteral(resourceName: "sweets_shave_ice")
    let image05 = #imageLiteral(resourceName: "job_interior_coordinator_man")
    
    var imgArray: [UIImage] = []
    
    @IBOutlet private weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func poi(_ sender: UIButton) {
        
        imgArray = [image01, image02, image03, image04, image05]
        
        let slideShow = Int(arc4random_uniform(5))
        
        imageview.image = imgArray[slideShow]
    }
    
}
