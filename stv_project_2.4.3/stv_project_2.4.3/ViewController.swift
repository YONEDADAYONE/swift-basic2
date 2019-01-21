//
//  ViewController.swift
//  stv_project_2.4.3
//
//  Created by 米田大弥 on 2019/01/21.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableVIew: UITableView!
    
    var forecasts = [ForecastList]()
    
    var image:ImageList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Forecaster.forecast { result in
            self.forecasts = result.forecasts
            print(self.forecasts)
            

            DispatchQueue.main.async {
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
        
//        cell.textLabel?.text = "\(self.forecasts[indexPath.row].dateLabel + self.forecasts[indexPath.row].date + self.forecasts[indexPath.row].telop)"
        
        //今日・明日・明後日を表示するラベル
        let label1 = cell.viewWithTag(1) as! UILabel
        label1.text = self.forecasts[indexPath.row].dateLabel
        
        //予報日を表示するラベル
        let label2 = cell.viewWithTag(2) as! UILabel
        label2.text = self.forecasts[indexPath.row].date
        
        //天気を表示するラベル
        let label3 = cell.viewWithTag(3) as! UILabel
        label3.text = self.forecasts[indexPath.row].telop
        
        
        let label4 = cell.viewWithTag(4) as! UILabel
//        label4.text =
        
//        let imge = cell.viewWithTag(5) as! UIImage
//        imageView.image = self.forecasts[indexPath.row].image
        
        //tableViewを可変にする。
        tableView.rowHeight = UITableView.automaticDimension
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}

