//
//  ViewController.swift
//  stv_project_2.5.7
//
//  Created by 米田大弥 on 2019/01/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import CoreLocation  // 現在地取得用
import MapKit
import UIKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var placeMapView: MKMapView!
    @IBOutlet private weak var detailTextView: UITextView!
    
    // 現在地取得用
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Plistの場所を探す
        let filePath = Bundle.main.path(forResource: "area", ofType: "plist")
        
        // Plistの中身をDictionary型で取り出す。
        //swiftlint使用したため三項演算子を導入
        let dics = NSDictionary(contentsOfFile: filePath ?? "")
        
        ////swiftlint使用
        print(dics as Any)
        
        for (key, data) in dics ?? NSDictionary() {
            print(key, "と", data)  // 確認用
            
            let title = key as? String
            let dic = data as? NSDictionary
            
            // dataの中身を取り出します
            print(dic?["description"] as Any)
            print(dic?["latitude"] as Any)
            
            // ピンの設定
            let pin = MKPointAnnotation()
            let latitude = dic?["latitude"] as? String
            let longitude = dic?["longitude"] as? String
            
            // ピンの位置の設定
            // atof(String) Stringから数字に変える関数
            pin.coordinate = CLLocationCoordinate2DMake(atof(latitude), atof(longitude))
            
            // ピンのタイトル、サブタイトルの設定
            pin.title = title
            pin.subtitle = dic?["description"] as? String
            
            // 地図に刺す
            placeMapView.addAnnotation(pin)
            
            placeMapView.delegate = self
        
            // 位置情報使用開始
            locationManager.startUpdatingLocation()
            
            // 位置情報使用許可のリクエスト表示
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.delegate = self
        }
        
        // 地図の設定 中心と表示範囲を指定
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let centerPin = MKPointAnnotation()
        centerPin.coordinate = CLLocationCoordinate2DMake(35.6236548, 139.7248582)  // 中心の座標設定
        
        let region = MKCoordinateRegion(center: centerPin.coordinate, span: span)
        
        placeMapView.setRegion(region, animated: true)
        
    }
    
    // ピンがタップされた時に発動
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        print(view.annotation?.title?)
        titleLabel.text = view.annotation?.title ?? ""
        detailTextView.text = view.annotation?.subtitle ?? ""
    }
    
//    // 位置情報がアップデートされた時に発動
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
////        print(#function,"first:",locations.first!)
////        print(#function,"last:",locations.last!)
//        print(locations.count)
//    }
    
}
