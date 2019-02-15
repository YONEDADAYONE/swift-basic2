//
//  RestaurantCell.swift
//  GotandaRestaurant
//
//  Created by 米田大弥 on 2019/02/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation
import UIKit

class RestaurantCell: UICollectionViewCell {
    
    @IBOutlet weak private var label1: UILabel!
    @IBOutlet weak private var label2: UILabel!
    @IBOutlet weak private var label3: UILabel!
    @IBOutlet weak private var label4: UILabel!
    @IBOutlet weak private var label5: UILabel!
    @IBOutlet weak private var label6: UILabel!
    @IBOutlet weak private var shopImageView: UIImageView!
    
    func catchLabel() -> UILabel {
        
        return label1
    }
    
    func catchLabel2() -> UILabel {
        
        return label2
    }
    
    func catchLabel3() -> UILabel {
        
        return label3
    }
    
    func catchLabel4() -> UILabel {
        
        return label4
    }
    
    func catchLabel5() -> UILabel {
        
        return label5
    }
    
    func catchLabel6() -> UILabel {
        
        return label6
    }
    
    func catchImageView() -> UIImageView {
        
        return shopImageView
    }
    
}
