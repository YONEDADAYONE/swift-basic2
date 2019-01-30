//
//  ViewController.swift
//  Calendar2
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

extension UIColor {
    //自作関数
    class func lightBlue() -> UIColor {
        //UIColorに色をつける
        return UIColor(red: 92.0 / 255, green: 192.0 / 255, blue: 210.0 / 255, alpha: 1.0)
    }
    
    //自作関数
    class func lightRed() -> UIColor {
        //UIColorに色をつける
        return UIColor(red: 195.0 / 255, green: 123.0 / 255, blue: 175.0 / 255, alpha: 1.0)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //ここ確認
    let dateManager =  DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    

    @IBOutlet weak var headerPrevBtn: UIButton!
    @IBOutlet weak var headerNextBtn: UIButton!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var calenderHeaderView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下3行コレクションビューを使うために必要
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = UIColor.white
        
        //headerTitleを今の月にする
        headerTitle.text = changeHeaderTitle(date: selectedDate)
        
        let check1 = dateManager.daysAcquisition()
        print(check1)
        
        let check2 = dateManager.firstDateOfMonth()
        print(check2)
        
        dateManager.dateForCellAtIndexPath(numberOfItem: 0)
    }
    
    //1 セクションを2つ作成
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    //2
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
        if section == 0 {
            return 35
        } else {
            return 7 //ここは月によって異なる
        }
    }

    //3
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        //テキストカラー
        if (indexPath.row % 7 == 0) {
            cell.textLabel.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.textLabel.textColor = UIColor.lightBlue()
        } else {
            cell.textLabel.textColor = UIColor.gray
        }
        //テキスト配置
        if indexPath.section == 0 {
            
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
        } else {
cell.textLabel.text = weekArray[indexPath.row]
            
        }

//        switch indexPath.section {
//        case 0:
//            cell.textLabel.text = weekArray[indexPath.row]
//        default:
//            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
//        }


        return cell
    }
    
    //下3つが無いとsection1の土曜日が2行目になる。
    //セルのサイズを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin: CGFloat = 8.0
        let width: CGFloat = (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height: CGFloat = width * 1.0
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellMargin
    }

    //headerの月を変更
    func changeHeaderTitle(date: NSDate) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = "M/yyyy"
        let selectMonth = formatter.string(from: date as Date)
        return selectMonth
    }
    
    @IBAction func tappedHeaderPrevBtn(_ sender: UIButton) {
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
        
    }
    
    @IBAction func tappedHeaderNextBtn(_ sender: UIButton) {
        
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
        
    }
    
    
}

