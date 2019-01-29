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
    var calendar = Calendar.current
    //定数dateFormatterでDateFormatter型を継承
    let dateFormatter = DateFormatter()
    //定数componentsでDateFormatter型を継承
    var components = DateComponents()
    
    func timeSetting() {
        //localeを設定。日本時間にする
        calendar.locale = Locale(identifier: "ja")
        //localeを設定。日本時間にする。
        dateFormatter.locale = Locale(identifier: "ja_JP")
        //dateFormatterを設定。yyyy年M月にする
        dateFormatter.dateFormat = "yyyy年M月"
        //componentsの年月日を設定
        //「今の年」を定数componentsのプロパティyearに入れる。今は2019年なので2019年
        components.year = calendar.component(.year, from: now)
        //「今の月」を定数componentsのプロパティmonthに入れる。今日は1月なので1月
        components.month = calendar.component(.month, from: now)
        components.weekday = calendar.component(.weekday, from: now)
        //日にちを⚪︎月1日にするため1をcomponents.dayに入れる。
        components.day = 1
    }
}
