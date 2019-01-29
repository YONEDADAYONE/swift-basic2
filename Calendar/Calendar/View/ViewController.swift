//
//  ViewController.swift
//  Calendar
//
//  Created by 米田大弥 on 2019/01/29.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController,
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var myCollectionView: UICollectionView!
    //モデルの継承
    let timeModel = TimeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //timeModelクラスのtimeSetting()を呼ぶ
        timeModel.timeSetting()
        //関数calculationを呼ぶ
        calculation()

    }
    
    //ラベルに今現在の月日を表示する&最初のページ(初期位置)を今現在の月日にする関数
    func calculation() {
        //定数firstDayOfMonthにcalの情報を入れる
        let firstDayOfMonth = timeModel.calendar.date(from: timeModel.components)
        dateLabel.text =  timeModel.dateFormatter.string(from: firstDayOfMonth ?? Date())
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //コレクションビューの要素を返す。今の状態だと37個のコレクションビューがある
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 37
    }
    
    //コレクションビューメソッド　表示する内容
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //アイデンティティファイアCellの値を定数cellにいれる
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        //firstDayOfMonthには2019年01月01日(水) 00:00を入れる。
        let firstDayOfMonth = timeModel.calendar.date(from: timeModel.components)
        //firstDayOfMonthを元に現在の曜日を取得し、定数firstWeekday 3が入っている。
        //1月1日が水曜なので3である
        let firstWeekday = timeModel.calendar.component(.weekday, from: firstDayOfMonth ?? Date())
        //weekdayAdding: 1日が何曜日かで変わるindexPath.rowに加える値
        let weekdayAdding = 2 - firstWeekday
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let label = UILabel()
        label.font = UIFont(name: "Arial", size: 17)
        label.text = "\(indexPath.row + weekdayAdding)"
        
        label.sizeToFit()
        label.center = cell.contentView.center
        cell.contentView.addSubview(label)
        
        switch label.text {
        case "0", "-1", "-2", "-3", "-4", "-5" :
            label.text = ""
        default:
            print("")
        }
        
        //1月・3月・5月・7月・8月・10月・12月の処理
        switch dateLabel.text?.contains("年1月") ?? true
            || dateLabel.text?.contains("年3月") ?? true
            || dateLabel.text?.contains("年5月") ?? true
            || dateLabel.text?.contains("年7月") ?? true
            || dateLabel.text?.contains("年8月") ?? true
            || dateLabel.text?.contains("年10月") ?? true
            || dateLabel.text?.contains("年12月") ?? true {
        case true:
            switch label.text {
            case "32":
                label.text = "1"
                label.alpha = 0.3
            case "33":
                label.text = "2"
                label.alpha = 0.3
            case "34":
                label.text = "3"
                label.alpha = 0.3
            case "35":
                label.text = "4"
                label.alpha = 0.3
            case "36":
                label.text = "5"
                label.alpha = 0.3
            case "37":
                label.text = "6"
                label.alpha = 0.3
            default:
                print("")
            }
        default:
            print("")
        }
        
        switch dateLabel.text?.contains("年2月") {
        case true:
            switch label.text {
            case "29":
                label.text = "1"
                label.alpha = 0.3
            case "30":
                label.text = "2"
                label.alpha = 0.3
            case "31":
                label.text = "3"
                label.alpha = 0.3
            case "32":
                label.text = "4"
                label.alpha = 0.3
            case "33":
                label.text = "5"
                label.alpha = 0.3
            case "34":
                label.text = "6"
                label.alpha = 0.3
            case "35":
                label.text = "7"
                label.alpha = 0.3
            case "36":
                label.text = "8"
                label.alpha = 0.3
            case "37":
                label.text = "9"
                label.alpha = 0.3
            default:
                print("")
            }
        default:
            print("")
        }
        
        switch dateLabel.text?.contains("年4月") ?? true
            || dateLabel.text?.contains("年6月") ?? true
            || dateLabel.text?.contains("年9月") ?? true
            || dateLabel.text?.contains("年11月") ?? true {
        case true:
            switch label.text {
            case "31":
                label.text = "1"
                label.alpha = 0.3
            case "32":
                label.text = "2"
                label.alpha = 0.3
            case "33":
                label.text = "3"
                label.alpha = 0.3
            case "34":
                label.text = "4"
                label.alpha = 0.3
            case "35":
                label.text = "5"
                label.alpha = 0.3
            case "36":
                label.text = "6"
                label.alpha = 0.3
            case "37":
                label.text = "7"
                label.alpha = 0.3
            default:
                print("")
            }
        default:
            print("")
        }
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let myBoundSize: CGFloat = UIScreen.main.bounds.size.width
        let cellSize: CGFloat = myBoundSize / 7.5
        return CGSize(width: cellSize, height: cellSize + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int)
        -> CGFloat {
        return 1
    }
    
    //<前月 を押した時のAction
    @IBAction func myActionZengetsu() {

        timeModel.components.month = timeModel.components.month!  - 1
        calculation()
        myCollectionView.reloadData()
    }
    
    //次月> を押した時のAction
    @IBAction func myActionJigetsu() {
    
        timeModel.components.month = timeModel.components.month!  + 1
        calculation()
        myCollectionView.reloadData()
    }
}
