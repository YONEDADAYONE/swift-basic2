//
//  CalendarCell.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {

    @IBOutlet weak private var dayLabel: UILabel!
    
    func catchLabel() -> UILabel {
        return dayLabel
    }
}
