//
//  CalendarViewController.swift
//  CalendarApp
//
//  Created by 米田大弥 on 2019/01/31.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

let dateManager = DateManager()

class CalendarViewController: UIViewController {
    
    //storyboadのIBOutlet宣言
    @IBOutlet weak private var nextMonthButton: UIBarButtonItem!
    @IBOutlet weak private var backMonthButton: UIBarButtonItem!
    @IBOutlet weak private var headerTitle: UILabel!
    @IBOutlet weak private var calenderCollectionView: UICollectionView!
    
    //下記メソッドでエラーがでるため必要
    private var selectedDate = Date()
    private var today: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //下3行コレクションビューを使うために必要
        calenderCollectionView.delegate = self
        calenderCollectionView.dataSource = self
        calenderCollectionView.backgroundColor = UIColor.white
        
        //headerTitleを今の月にする
        headerTitle.text = dateManager.changeHeaderTitle(date: selectedDate)
        
        if headerTitle.text?.contains("2019年1月") ?? true {
            backMonthButton.isEnabled = false
        }
    }
    
    //次へボタンタップ時
    @IBAction private func tappedNextMonthButton(_ sender: UIBarButtonItem) {
        //もしヘッダーのテキストに2019年11月という文字があれば
        if headerTitle.text?.contains("2019年11月") ?? true {
            //「次へ」ボタンを無効にする
            nextMonthButton.isEnabled = false
            //もしヘッダーのテキストに2019年という文字があれば
        } else if headerTitle.text?.contains("2019年") ?? true {
            //「戻る」ボタンを有効にする
            backMonthButton.isEnabled = true
        }
        selectedDate = dateManager.nextMonth(date: selectedDate)
        calenderCollectionView.reloadData()
        headerTitle.text = dateManager.changeHeaderTitle(date: selectedDate)
    }
    
    //前へボタンタップ時
    @IBAction private func tappedBackMonthButton(_ sender: UIBarButtonItem) {
        //もしヘッダーのテキストに2019年1月という文字があれば
        if headerTitle.text?.contains("2019年2月") ?? true {
            //「戻る」ボタンを無効にする
            backMonthButton.isEnabled = false
        } else if headerTitle.text?.contains("2019年") ?? true {
            //「進む」ボタンを無効にする
            nextMonthButton.isEnabled = true
        }
        selectedDate = dateManager.prevMonth(date: selectedDate)
        calenderCollectionView.reloadData()
        headerTitle.text = dateManager.changeHeaderTitle(date: selectedDate)
    }
    
}

extension UIColor {
    //自作関数
    class open func lightBlue() -> UIColor {
        //UIColorに色をつける
        let color =  #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1)
        
        return color
    }
    
    //自作関数
    class open func lightRed() -> UIColor {
        //UIColorに色をつける
        let color =  #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        //UIColorに色をつける
        return color
    }
    
    //自作関数
    class open func black() -> UIColor {
        //UIColorに色をつける
        let color =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        //UIColorに色をつける
        return color
    }
}

extension UIViewController: UICollectionViewDataSource {
    
    //1 セクション数を決める。今回は曜日と日にちの2種類を出したいので2にした
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    //2 セルの数決める　今回は月火水...と1~31の2種類
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 7
        case 1:
            //            print("知りたいのは\(dateManager.daysAcquisition())")
            return dateManager.daysAcquisition()//数を変える
        default:
            print("error")
            return 0
        }
    }
    
    //3 cell内のテキストカラー及びテキスト配置を決める
    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CalendarCell
            
            let weekArray = ["日", "月", "火", "水", "木", "金", "土"]
            
            //土曜日・日曜日を識別し土曜日だったらお青色に日曜日だったら赤色にする。
            if indexPath.row % 7 == 0 {
                cell?.dayLabel?.textColor = UIColor.lightRed()
            } else if indexPath.row % 7 == 6 {
                cell?.dayLabel?.textColor = UIColor.lightBlue()
                print(indexPath.row)
            } else {
                cell?.dayLabel?.textColor = UIColor.black()
            }
            //1行目に1週間の曜日を2行目にその月のカレンダーをテキスト配置する。
            if indexPath.section == 0 {
                cell?.dayLabel?.text = weekArray[indexPath.row]
            } else {
                //月によって1日の場所は異なる
                cell?.dayLabel?.text = dateManager.conversionDateFormat(indexPath: indexPath)
            }
            
            //表示している月以外の日付を非活性状態にする。
            switch indexPath.row {
            case 0...5:
                if cell?.dayLabel?.text?.count == 2 {
                    cell?.dayLabel?.textColor = UIColor.gray
                }
            case 29...35:
                if cell?.dayLabel?.text?.count == 1 {
                    cell?.dayLabel?.textColor = UIColor.gray
                }
            case 36...42:
                if cell?.dayLabel?.text?.count == 1 {
                    cell?.dayLabel?.textColor = UIColor.gray
                }
            default:
                print("色の変更は無し")
            }
            
            return cell ?? CalendarCell()
    }
    
}

extension UIViewController: UICollectionViewDelegate {
    
}

extension UIViewController: UICollectionViewDelegateFlowLayout {
    
    //セルのサイズを設定    下記3つのメソッドが無いとsection1の土曜日が2行目になるので調整のため追加。
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellMargin: CGFloat = 2.0
        let daysPerWeek = 7
        let numberOfMargin: CGFloat = 8.0
        let width =
            (collectionView.frame.size.width - cellMargin * numberOfMargin) / CGFloat(daysPerWeek)
        let height = width * 1.7
        return CGSize(width: width, height: height)
    }
    
    //セルの垂直方向のマージンを設定
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cellMargin: CGFloat = 2.0
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cellMargin: CGFloat = 2.0
        return cellMargin
    }
}
