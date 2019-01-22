//
//  ViewController.swift
//  stv_project_2.4.4
//
//  Created by 米田大弥 on 2019/01/10.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var forecasts = [ForecastList]()
    
    var tableArray = ["予報日" , "天気" , "天気アイコンのURL"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        Forecaster.forecast { result in
            self.forecasts = result.forecasts
            print(self.forecasts)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
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

        cell.textLabel?.text = "\(self.forecasts[indexPath.row].dateLabel)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detaiVC = segue.destination as? DetailViewController {
            detaiVC.forecasts = sender as? String
            print(sender)
        }
        
    }
    
    //tableviewをタップしたら遷移する。 //
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segue", sender: forecasts[indexPath.row].dateLabel)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
