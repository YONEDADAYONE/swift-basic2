//
//  ViewController.swift
//  Calendar2
//
//  Created by 米田大弥 on 2019/01/30.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //ここ確認
    let dateManager =  DateManager()
    let daysPerWeek: Int = 7
    let cellMargin: CGFloat = 2.0
    var selectedDate = NSDate()
    var today: NSDate!
    let weekArray = ["日", "月", "火", "水", "木", "金", "土"]


    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var calenderHeaderView: UIView!
    @IBOutlet weak var calenderCollectionView: UICollectionView!

    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var goButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //下3行コレクションビューを使うために必要
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = UIColor.white
        
        //headerTitleを今の月にする
        headerTitle.text = changeHeaderTitle(date: selectedDate)
        
//        let check1 = dateManager.daysAcquisition()
//        print(check1)
//
//        let check2 = dateManager.firstDateOfMonth()
//        print(check2)
//
//        dateManager.dateForCellAtIndexPath(numberOfItem: 0)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if headerTitle.text?.contains("2019年") ?? true {
            backButton.isEnabled = false
        } else {
            goButton.isEnabled = true
        }
        
    }
    
    //1 セクション数を決める 今回はセクションを2つ作成
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        return 2
//    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    //2 セルの数決める　今回は月火水...と1~31の2種類

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Section毎にCellの総数を変える.
//        if section == 0 {
//            return 7
//        } else {
//            return dateManager.daysAcquisition() //ここは月によって異なる
//        }
        
        // Section毎にCellの総数を変える.
        switch section{
        case 0:
            return 7
            
        case 1:
            return dateManager.daysAcquisition()//数を変える
            
        default:
            print("error")
            return 0
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
            cell.textLabel.text = weekArray[indexPath.row]
        } else {
            cell.textLabel.text = dateManager.conversionDateFormat(indexPath: indexPath)
            //月によって1日の場所は異なる
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
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateFormat = "yyyy年M月"
        let selectMonth = formatter.string(from: date as Date)
        return selectMonth
    }
    
    @IBAction func tapBackButton(_ sender: UIBarButtonItem) {
        
        selectedDate = dateManager.prevMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
        
        if headerTitle.text?.contains("2019年1月") ?? true {
            backButton.isEnabled = false
        } else if headerTitle.text?.contains("2019年") ?? true {
            goButton.isEnabled = true
        }
    }
    
    
    @IBAction func tapGoButton(_ sender: UIBarButtonItem) {
        
        if headerTitle.text?.contains("2019年11月") ?? true {
            goButton.isEnabled = false
        } else if headerTitle.text?.contains("2019年") ?? true {
            backButton.isEnabled = true
        }
        
        selectedDate = dateManager.nextMonth(date: selectedDate as Date) as NSDate
        calenderCollectionView.reloadData()
        headerTitle.text = changeHeaderTitle(date: selectedDate)
    
}

}

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
