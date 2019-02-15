//
//  RestaurantViewController.swift
//  GotandaRestaurant
//
//  Created by 米田大弥 on 2019/02/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class RestaurantViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //配列が入っている
    var forecasts = [ForecastList]()
    
    @IBOutlet weak private var restaurantCollectionView: UICollectionView!
    
    var cachemodel = Cachemodel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restaurantCollectionView.delegate = self
        restaurantCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //"Cellはストーリーボードで設定したセルのID"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? RestaurantCell
        
        cell?.catchLabel().text = self.forecasts[indexPath.row].dateLabel
        
        cell?.catchLabel2().text = self.forecasts[indexPath.row].date
        
        cell?.catchLabel3().text = self.forecasts[indexPath.row].telop

        cell?.catchLabel4().text = self.forecasts[indexPath.row].image.url
        
        cell?.catchLabel5().text = self.forecasts[indexPath.row].dateLabel
        
        cell?.catchLabel6().text = self.forecasts[indexPath.row].date
        
        DispatchQueue.main.async {
            
            guard let url = URL(string: self.forecasts[indexPath.row].image.url) else {
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                let imageView = cell?.catchImageView()
                imageView?.image = image
                cell?.catchImageView().image = image
                
            } catch let err {
                print("Error : \(err.localizedDescription)")
            }
        }
        
        return cell ?? RestaurantCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Forecaster.forecast { result in
            //上で宣言したforecastsはweatherクラスの定数resultのプロパティforecasts
            self.forecasts = result.forecasts
            
            //非同期処理
            DispatchQueue.main.async {
                //ViewControllerのCollectionViewをリロードしている。
                self.restaurantCollectionView.reloadData()
            }
            
        }
    }

}
