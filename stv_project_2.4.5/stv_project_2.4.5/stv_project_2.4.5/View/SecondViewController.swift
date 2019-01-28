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
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weekdateLabel: UILabel!
    @IBOutlet private weak var telopLabel: UILabel!
    @IBOutlet private weak var imageurlLabel: UILabel!
    @IBOutlet private weak var imageView: UIImageView!
    
    var imgString: String?
    
    var cachemodel = Cachemodel()
    
    @IBAction func button(_ sender: UIButton) {
        
        loadView()
        
        dateLabel.text = storage.weatherDate
        weekdateLabel.text = storage.weatherDatelabel
        telopLabel.text = storage.weatherTelop
        imageurlLabel.text = storage.weatherImageurl
        
        cacheProcessing()
    }
    
    func cacheProcessing() {
        
        //Modelフォルダのキャッシュの値を保管する定数を呼び出し
        let myCache = cachemodel.imageCache
        //Modelフォルダのキャッシュクラスに値を登録
        cachemodel.url = URL(string: (forecastList?.image.url ?? ""))
        //Modelフォルダのユーザーデフォルツの登録
        cachemodel.addUserdefaultsUrl()
        
        //requestURL = cachemodel.url であるなら
        guard let requestURL = cachemodel.url else {
            return
        }
        //requestURLのデータを元に画像イメージを設定。
        let task = URLSession.shared.dataTask(with: requestURL) {data, _, _ in
            let image = UIImage(data: data ?? Data())
            //UIImageView.image must be used from main thread onlyというエラーがでたので、それを解消するために
            //DispatchQueue.main.async{}を追加
            DispatchQueue.main.async {
                // メインスレッドで実行 UIの処理など
                self.imageView.image = image
                print("gggggggggggggggg")
                
                if self.imageView.image == image {
                    print("あああああああ")
                }
            }
        }
        //task.resume()でタスクを開始する。
        task.resume()
        
        //Cachmodelクラスのキャッシュを保管している「imageCache」の値を定数imageFromCacheに入れる。
        //この時、キーをお天気のURLの値を保持しているcachemodel.url にすることで画像データを保存できる。
        if let imageFromCache = myCache.object(forKey: cachemodel.url as AnyObject) {
            //imageViewのimage を　キャッシュのイメージにする
            imageView.image = imageFromCache
        }
        
        //上記のifに引っかからないということは、キャッシュとして保存されていないということなので、以下でキャッシュ化をしていく。
        //URLSessionクラスのdataTaskメソッドで、urlを元にして、バックグランドでサーバーと通信を行う。
        //{ 以降はcompletionHandler(クロージャー)で、通信処理が終わってから実行される。
        //dataはサーバーからの返り値。urlResponseは。HTTPヘッダーやHTTPステータスコードなどの情報。リクエストが失敗したときに、
        //errorに値が入力される。失敗しない限り、nilとなる。
        let tasktask = URLSession.shared.dataTask(with: requestURL) { _, _, error in
            //errorがnilじゃないということは、リクエストに失敗しているということ。returnで抜け出す。
            if error != nil {
                print("エラー")
                return
            }
        }
        
        guard let image = UIImage(data: Data()) else {
            return
        }
        myCache.setObject(image, forKey: erfl as AnyObject)
        
        //リクエストが成功して、サーバーからのresponseがある状態。
        DispatchQueue.main.async {
            self.imageView.image = image
            print("kkkkkkkkkkkkkkkkkkkkk")
        }

        tasktask.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storage.weatherDate = forecastList?.date ?? UserDefaults.standard.string(forKey: "save10")!
        storage.weatherDatelabel = forecastList?.dateLabel ?? UserDefaults.standard.string(forKey: "save11")!
        storage.weatherTelop = forecastList?.telop ?? UserDefaults.standard.string(forKey: "save12")!
        storage.weatherImageurl = forecastList?.image.url ?? UserDefaults.standard.string(forKey: "save13")!
        
        storage.addUserdefaults()
        
        dateLabel.text = storage.weatherDate
        weekdateLabel.text = storage.weatherDatelabel
        telopLabel.text = storage.weatherTelop
        imageurlLabel.text = storage.weatherImageurl
        
        cacheProcessing()
    }
}
