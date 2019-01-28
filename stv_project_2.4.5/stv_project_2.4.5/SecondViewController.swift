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
    
    @IBAction func button(_ sender: UIButton) {
        
        loadView()
        
        dateLabel.text = storage.weatherDate
        weekdateLabel.text = storage.weatherDatelabel
        telopLabel.text = storage.weatherTelop
        imageurlLabel.text = storage.weatherImageurl
        
        imgString =
            forecastList?.image.url
            ??
        "http://www.gibe-on.info/wp-content/uploads/2016/05/%E3%83%8A%E3%83%9E%E3%82%B1%E3%83%A2%E3%83%8E.jpg"
        
        print(imgString ?? "")
        
        imageView.cacheImage(imageUrlString: imgString ?? "")
        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imgString = forecastList?.image.url
            ??
        "http://www.gibe-on.info/wp-content/uploads/2016/05/%E3%83%8A%E3%83%9E%E3%82%B1%E3%83%A2%E3%83%8E.jpg"
        
        print(imgString ?? "")
        
        imageView.cacheImage(imageUrlString: imgString ?? "")
        
    }
    
}
extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    //読み込むURLのstringを引数にする。
    func cacheImage(imageUrlString: String) {
        
        //引数のimageUrlStringをURLに型変換する。
        let url = URL(string: imageUrlString)
        
        //引数で渡されたimageUrlStringがすでにキャッシュとして保存されている場合は、キャッシュからそのimageを取り出し、self.imageに代入し、returnで抜ける。
        if let imageFromCache = UIImageView.imageCache.object(forKey: imageUrlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        //上記のifに引っかからないということは、キャッシュとして保存されていないということなので、以下でキャッシュ化をしていく。
        //URLSessionクラスのdataTaskメソッドで、urlを元にして、バックグランドでサーバーと通信を行う。
        //{ 以降はcompletionHandler(クロージャー)で、通信処理が終わってから実行される。
        //dataはサーバーからの返り値。urlResponseは。HTTPヘッダーやHTTPステータスコードなどの情報。リクエストが失敗したときに、errorに値が入力される。失敗しない限り、nilとなる。¥
        
        if let bindString = url {
            print(bindString)
            
            URLSession.shared.dataTask(with: bindString) { data, _, error in
                
                //errorがnilじゃないということは、リクエストに失敗しているということ。returnで抜け出す。
                if error != nil {
                    print("error")
                    return
                }
                
                //リクエストが成功して、サーバーからのresponseがある状態。
                //しかし、UIKitのオブジェクトは必ずメインスレッドで実行しなければならないので、DispatchQueue.mainでメインキューに処理を追加する。非同期で登録するので、asyncで実装。
                DispatchQueue.main.async {
                    
                    //サーバーからのレスポンスのdataを元にして、UIImageを取得し、imageToCacheに代入。
                    let imageToCache = UIImage(data: data ?? Data())
                    
                    //self.imageにimageToCacheを代入。
                    self.image = imageToCache
                    
                    //keyをimageUrlStringとして、imageToCacheをキャッシュとして保存する。
                    UIImageView.imageCache.setObject(imageToCache ?? UIImage(), forKey: imageUrlString as AnyObject)
                }
                }.resume()
        }
        
    }
    
}
