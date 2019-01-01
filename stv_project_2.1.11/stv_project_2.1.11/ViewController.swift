//
//  ViewController.swift
//  stv_project_2.1.11
//
//  Created by 米田大弥 on 2018/12/31.
//  Copyright © 2018 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,
UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet private var table: UITableView!
    private var titleValueArray: NSArray?
    private var subTitleArray: NSArray?
    private var imagesArray: NSArray?
    private var imagesArray2: NSArray?
    private var imagesArray3: NSArray?
    
    //セクション名
    let sectionTitle: NSArray = ["セクション1", "セクション2", "セクション3"]
    
    // Section数
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    // Sectionのタイトル
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section] as? String
    }
    
    //何行表示するのかを指定する。
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return imagesArray?.count ?? 0
        } else if section == 1 {
            return imagesArray2?.count ?? 0
        } else if section == 2 {
            return imagesArray3?.count ?? 0
        } else {
            return 0
        }
        //        return titleValueArray?.count ?? 0
    }
    
    //指定された行に(indexPath.row)に、どんな内容のセルを表示するかを指定する。
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // tableCell の ID で UITableViewCell のインスタンスを生成
        let cell = table.dequeueReusableCell(withIdentifier: "testCell",
                                             for: indexPath)
        
        //        let img = UIImage(named: (imagesArray?[indexPath.row] as? String ?? ""))
        //
        //        // Tag番号 1 で UIImageView インスタンスの生成
        //        let imageView = cell.viewWithTag(1) as? UIImageView
        //        imageView?.image = img
        
        // Section毎に処理を分ける。
        if indexPath.section == 0 {
            let img = UIImage(named: (imagesArray?[indexPath.row] as? String ?? ""))
            // Tag番号 1 で UIImageView インスタンスの生成
            let imageView = cell.viewWithTag(1) as? UIImageView
            imageView?.image = img
            
            // Label インスタンスの生成
            cell.textLabel?.text = titleValueArray?[indexPath.row] as? String
            cell.detailTextLabel?.text = subTitleArray?[indexPath.row] as? String
        } else if indexPath.section == 1 {
            let img = UIImage(named: imagesArray2?[indexPath.row] as? String ?? "")
            // Tag番号 1 で UIImageView インスタンスの生成
            let imageView = cell.viewWithTag(1) as? UIImageView
            imageView?.image = img
            
            // Label インスタンスの生成
            cell.textLabel?.text = titleValueArray?[indexPath.row] as? String
            cell.detailTextLabel?.text = subTitleArray?[indexPath.row] as? String
        } else if indexPath.section == 2 {
            let img = UIImage(named: (imagesArray3?[indexPath.row] as? String ?? ""))
            // Label インスタンスの生成
            cell.textLabel?.text = titleValueArray?[indexPath.row] as? String
            cell.detailTextLabel?.text = subTitleArray?[indexPath.row] as? String
            
        }
        
        //tableviewの行のcellにテキストラベルを入れる
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //セルを可変にする
        table.rowHeight = UITableView.automaticDimension
        
        //NSDictionaryはオブジェクトをキー値と要素を対として保持する配列クラスです。plistの情報を定数dicRootに入れる
        let dicRoot = NSDictionary.init(contentsOfFile: Bundle.main.path(forResource: "Created", ofType: "plist") ?? "")
        
        //plistのTitle情報を定数titleArrayFromDicに入れる
        let titleArrayFromDic: NSArray = NSArray.init(object: dicRoot?.object(forKey: "Title") as Any)
        
        titleValueArray = (titleArrayFromDic.object(at: 0) as? NSArray)
        
        let subTitleArrayFormDic: NSArray = NSArray.init(object: dicRoot?.object(forKey: "subTitle") as Any)
        
        subTitleArray = (subTitleArrayFormDic.object(at: 0) as? NSArray)
        
        let imagesArrayFormDic: NSArray = NSArray.init(object: dicRoot?.object(forKey: "image") as Any)
        
        imagesArray = (imagesArrayFormDic.object(at: 0) as? NSArray)
        
        let imagesArrayFormDic2: NSArray = NSArray.init(object: dicRoot?.object(forKey: "image2") as Any)
        
        imagesArray2 = (imagesArrayFormDic2.object(at: 0) as? NSArray)
        
        let imagesArrayFormDic3: NSArray = NSArray.init(object: dicRoot?.object(forKey: "image3") as Any)
        
        imagesArray3 = (imagesArrayFormDic3.object(at: 0) as? NSArray)
        
        //        for count in 0..<titleValueArray?.count {
        //            print(titleValueArray[count])
        //            print(subTitleArray[count])
        //            print(imagesArray[count])
        //        }
        
    }
    
    // Cell の高さを125にする
    func tableView(_ table: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
}
