//
//  DateManager.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

import UIKit

extension Date {
    
    func monthAgoDate() -> Date {
        let addValue = -1
        
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        
        return calendar.date(byAdding: dateComponents, to: self) ?? Date()
    }
    
    func monthLaterDate() -> Date {
        let addValue: Int = 1
        
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        
        return calendar.date(byAdding: dateComponents, to: self) ?? Date()
    }
}

class DateManager: NSObject {
    
    var currentMonthOfDates = [NSDate]() //表記する月の配列
    
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    var numberOfItems: Int = 0 //セルの個数 nilが入らないようにする
    
    //月ごとのセルの数を返すメソッド。check1で確認済み数は返されてる。
    func daysAcquisition() -> Int {
        
        if let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date) {
            let numberOfWeeks = rangeOfWeeks.count //月が持つ週の数
            numberOfItems = numberOfWeeks * daysPerWeek //週の数×列の数
        }
        
        return numberOfItems
    }
    //月の初日を取得。check1で確認済初日は取得できている。
    func firstDateOfMonth() -> Date {
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        components.day = 1
        
        let firstDateMonth = Calendar.current.date(from: components)
        return firstDateMonth ?? Date()
    }
    
    // ⑴表記する日にちの取得 //サイト通りになっていてあってる
    func dateForCellAtIndexPath(numberOfItem: Int) {
        // ①「月の初日が週の何日目か」を計算する
        // 修正前 NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day,
        //inUnit: NSCalendarUnit.WeekOfMonth, forDate: firstDateOfMonth())
        guard let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day,
                                                                     in: .weekOfMonth, for: firstDateOfMonth()) else {
                                                                        return
        }
        // 修正前 for var i = 0; i < numberOfItems; i++ {
        for integer in 0 ..< numberOfItems {
            // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            var dateComponents = DateComponents()
            // 修正前 (ordinalityOfFirstDay - 1)
            dateComponents.day = integer - (ordinalityOfFirstDay - 1)
            // ③ 表示する月の初日から②で計算した差を引いた日付を取得
            // 修正前 NSCalendar.currentCalendar().dateByAddingComponents(dateComponents,
            //toDate: firstDateOfMonth(), options: NSCalendarOptions(rawValue: 0))!
            let date = Calendar.current.date(byAdding: dateComponents as DateComponents,
                                             to: firstDateOfMonth() as Date)
            // ④配列に追加
            // 🔴修正前 (date)
            currentMonthOfDates.append(date as NSDate? ?? NSDate())
            
            //            print(currentMonthOfDates)
        }
    }
    
    // ⑵表記の変更
    func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItem: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
    
    //前月の表示
    
    func prevMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    
    //次月の表示
    
    func nextMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
    
}
