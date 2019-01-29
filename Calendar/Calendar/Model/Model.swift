//
//  Model.swift
//  Calendar
//
//  Created by 米田大弥 on 2019/01/29.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class TimeModel {
    //定数nowでDate型を継承
    let now = Date()
    //定数calにCalendar.current機能を実装
    var cal = Calendar.current
    //定数dateFormatterでDateFormatter型を継承
    let dateFormatter = DateFormatter()
    //定数componentsでDateFormatter型を継承
    var components = DateComponents()
    
}
