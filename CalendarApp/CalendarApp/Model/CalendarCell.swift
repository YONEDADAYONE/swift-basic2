//
//  CalendarCell.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    
    public var dayLabel: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //textLabelのプロパティを設定
        dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        dayLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        dayLabel?.textAlignment = NSTextAlignment.center
        
        // Cellに追加
        self.addSubview(dayLabel ?? UILabel())
    }
    
    //継承
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}
