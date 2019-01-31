//
//  DateManager.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation
import UIKit

class DateManager: NSObject {
    
    public var currentMonthOfDates = [NSDate]() //表記する月の配列
    public var selectedDate = Date()
    public let daysPerWeek = 7
    public var numberOfItems = 0 //セルの個数 初期値を0にする。
    
    //月ごとのセルの数を返すメソッド。printで確認済み数は返されてる。
    public func daysAcquisition() -> Int {
        
        if let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth() as Date) {
            let numberOfWeeks = rangeOfWeeks.count //月が持つ週の数
            numberOfItems = numberOfWeeks * daysPerWeek //週の数×列の数
        }
        return numberOfItems
    }
    //月の初日を取得。printで確認済初日は取得できている。
    public func firstDateOfMonth() -> Date {
        
        var components = Calendar.current.dateComponents([.year, .month, .day], from: selectedDate)
        components.day = 1
        
        let firstDateMonth = Calendar.current.date(from: components)
        return firstDateMonth ?? Date()
    }
    
    // ⑴表記する日にちの取得
    public func dateForCellAtIndexPath(numberOfItem: Int) {
        // ①「月の初日が週の何日目か」を計算する
        guard let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day,
                                                                     in: .weekOfMonth, for: firstDateOfMonth()) else {
        return
        }
        for integer in 0 ..< numberOfItems {
            // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
            var dateComponents = DateComponents()
            dateComponents.day = integer - (ordinalityOfFirstDay - 1)
            // ③ 表示する月の初日から②で計算した差を引いた日付を取得
            let date = Calendar.current.date(byAdding: dateComponents as DateComponents,
                                             to: firstDateOfMonth() as Date)
            // ④配列に追加
            currentMonthOfDates.append(date as NSDate? ?? NSDate())
            //↓配列を確認するプリント 確認できたのでコメントアウト済み。
            //print(currentMonthOfDates)
        }
    }
    
    // ⑵表記の変更
    public func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItem: numberOfItems)
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row] as Date)
    }
    
    //前月の表示
    public func prevMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
    }
    
    //次月の表示
    public func nextMonth(date: Date) -> Date {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
    }
    
}

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
