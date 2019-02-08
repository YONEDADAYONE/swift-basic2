//
//  CalendarTextModel.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/02/08.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation
import UIKit

class CalendarTextModel {
    
    //    func mainColor() -> Color {
    //        return
    //    }
    
    //カレンダークラスを参照
    var calendar = Calendar.current
    
    func aaa() {
        calendar.locale = Locale(identifier: "ja")
        let shortWeekdaySymbols = calendar.shortWeekdaySymbols
        
    }

    
}
