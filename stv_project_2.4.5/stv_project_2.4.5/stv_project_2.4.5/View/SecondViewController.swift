//
//  SecondViewController.swift
//  stv_project_2.4.5
//
//  Created by 米田大弥 on 2019/01/25.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    let storage = Storage()
    
    //データをもらう
    var forecastList: ForecastList?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekdateLabel: UILabel!
    @IBOutlet weak var telopLabel: UILabel!
    @IBOutlet weak var imageurlLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var imgString: String?
    
    var cachemodel = Cachemodel()
    
    @IBAction func button(_ sender: UIButton) {
        
        loadView()
        
        dateLabel.text = storage.weatherDate
        weekdateLabel.text = storage.weatherDatelabel
        telopLabel.text = storage.weatherTelop
        imageurlLabel.text = storage.weatherImageurl
        
        aaa()
    }
    
    
    func aaa() {

        //キャッシュの入れ物
        let myCache = cachemodel.imageCache
        //キャッシュクラスに値を登録
        cachemodel.url = URL(string: (forecastList?.image.url)!)
        //ユーザーデフォルツの登録
        cachemodel.ccc()
        
        //achemodelクラスからもらってきたURLRequest型にする。
        let req = URLRequest(url: cachemodel.url!)
        
        NSURLConnection.sendAsynchronousRequest(req, queue:OperationQueue.main){(res, data, err) in
            let image = UIImage(data:data!)
            self.imageView.image = image
        }

        
        if let imageFromCache = myCache.object(forKey: cachemodel.url as AnyObject) {
            imageView.image = imageFromCache
        }
        
        URLSession.shared.dataTask(with: cachemodel.url!) { (data, _, error) in
            
            if error != nil {
                print("エラー")
                return
            }
        }
        
        guard let image = UIImage(data: Data()) else {
            return
        }
        
        myCache.setObject(image, forKey: erfl as AnyObject)
        
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage.weatherDate = forecastList?.date ?? "エラー"
        storage.weatherDatelabel = forecastList?.dateLabel ?? "エラー"
        storage.weatherTelop = forecastList?.telop ?? "エラー"
        storage.weatherImageurl = forecastList?.image.url ?? "エラー"
        
        storage.ddd()
        
        dateLabel.text = storage.weatherDate
        weekdateLabel.text = storage.weatherDatelabel
        telopLabel.text = storage.weatherTelop
        imageurlLabel.text = storage.weatherImageurl
        
        aaa()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        imgString = forecastList?.image.url
//            ??
//        "http://www.gibe-on.info/wp-conFtent/uploads/2016/05/%E3%83%8A%E3%83%9E%E3%82%B1%E3%83%A2%E3%83%8E.jpg"
        
        
    }
    
}
