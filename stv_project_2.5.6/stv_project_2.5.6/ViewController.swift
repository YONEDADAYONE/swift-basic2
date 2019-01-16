//
//  ViewController.swift
//  stv_project_2.5.6
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit
import CoreLocation  // 現在地取得用

class ViewController: UIViewController
    ,CLLocationManagerDelegate
{
    
    // 現在地取得用
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Plistの場所を探す
        let filePath = Bundle.main.path(forResource: "area", ofType: "plist")
        
        // Plistの中身をDictionary型で取り出す。
        let dics = NSDictionary(contentsOfFile: filePath!)
        
        for (_,data) in dics! {
            
            let dic = data as! NSDictionary
            
            // dataの中身を取り出しましょう
            print(dic["longitude"]!)
            print(dic["latitude"]!)
            
            // 位置情報使用開始
            locationManager.startUpdatingLocation()
            
            // 位置情報使用許可のリクエスト表示
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.delegate = self
            
        }
        
    }
    
}

