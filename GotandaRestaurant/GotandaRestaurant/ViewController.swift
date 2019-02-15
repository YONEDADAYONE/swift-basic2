//
//  ViewController.swift
//  GotandaRestaurant
//
//  Created by 米田大弥 on 2019/02/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak private var tableVIew: UITableView!
    
    //ForecastListの配列が入っている
    var forecasts = [ForecastList]()
    //descriptionのstringが入っている
//    var descriptions: DescriptionList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Forecaster.forecast { result in
            //上で宣言したforecastsはweatherクラスの定数resultのプロパティforecasts
            self.forecasts = result.forecasts
            //上で宣言したdescriptionはweatherクラスの定数resultのプロパティdescription
//            self.descriptions = result.description
            
            print(self.forecasts)
            print(self.description)
            
            //非同期処理
            DispatchQueue.main.async {
                //ViewControllerのtableviewをリロードしている。
                self.tableVIew.reloadData()
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(forecasts.count)
        return forecasts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //今日・明日・明後日を表示するラベル
        let label1 = cell.viewWithTag(1) as? UILabel
        label1?.text = self.forecasts[indexPath.row].dateLabel
        
        //予報日を表示するラベル
        let label2 = cell.viewWithTag(2) as? UILabel
        label2?.text = self.forecasts[indexPath.row].date
        
        //天気を表示するラベル
        let label3 = cell.viewWithTag(3) as? UILabel
        label3?.text = self.forecasts[indexPath.row].telop
        
//        let label4 = cell.viewWithTag(4) as? UILabel
//        label4?.text = self.descriptions?.text
        
        print("非同期処理チェック1")
        
        DispatchQueue.main.async {
            
            guard let url = URL(string: self.forecasts[indexPath.row].image.url) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                let imageView = cell.viewWithTag(5) as? UIImageView
                imageView?.image = image
                print("非同期処理チェック最後")
                
            } catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
        
        print("非同期処理チェック2")
        //tableViewを可変にする。ができていない?
        tableView.rowHeight = UITableView.automaticDimension
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
