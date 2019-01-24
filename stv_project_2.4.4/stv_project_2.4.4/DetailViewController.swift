//
//  DetailViewController.swift
//  stv_project_2.4.4
//
//  Created by 米田大弥 on 2019/01/24.
//  Copyright © 2019 hiroya. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //データをもらう
     var forecastList:ForecastList?
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekdateLabel: UILabel!
    @IBOutlet weak var telopLabel: UILabel!
    @IBOutlet weak var imageurlLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    let imgString = "https://2.bp.blogspot.com/-K7iU90zhGf0/XBRfNSR2sVI/AAAAAAABQ3E/6wvDgHZYBSA__vHh8-dpRqFhZRHMjPdnwCLcBGAs/s800/sweets_kaichu_shiruko_oshiruko.png"
    
    //ユーザーデフォルツを使用する
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.cacheImage(imageUrlString: imgString)
        
        //画像を表示する。
//        guard let url = URL(string: forecastList?.image.url ?? "") else {
//            return
//        }
//
//        do {
//            let data = try Data(contentsOf: url)
//            let image = UIImage(data: data)
//            imageView?.image = image
//
//        } catch let err {
//            print("Error : \(err.localizedDescription)")
//        }
        //ここまで画像の設定
        
        //もしユーザーデフォルツでに値があればそれをいれる。これをオフラインにできないものか...
        if userDefaults.object(forKey: "save1") != nil {
            dateLabel.text = userDefaults.object(forKey: "save1") as? String
        }
        
        //データラベルをforecastListの値にする。
        dateLabel.text = forecastList?.date
        weekdateLabel.text = forecastList?.dateLabel
        telopLabel.text = forecastList?.telop
        imageurlLabel.text = forecastList?.image.url
        
        //ラベルの文字列を保存する。
        userDefaults.set(dateLabel.text, forKey: "save1")
        userDefaults.set(weekdateLabel.text, forKey: "save2")
        userDefaults.set(telopLabel.text, forKey: "save3")
        userDefaults.set(telopLabel.text, forKey: "save4")
        
        //plistファイルへの出力と同期する。
        userDefaults.synchronize()
        
        //内容確認
        if UserDefaults.standard.object(forKey: "save1") != nil {
            print("値はあるよ")
        }
    }
    
//    func cash(url: String) {
//
//        let url = URL(string: (forecastList?.image.url)!)
//        print(url!)
//
//
//        //引数で渡されたimageUrlStringがすでにキャッシュとして保存されている場合は、キャッシュからそのimageを取り出し、self.imageに代入し、returnで抜ける。
//        if let imageFromCache = UIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {
//            self.imageView = imageFromCache
//            return
//    }
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
    }
    
}
extension UIImageView {

    //まず入れ物を用意します
    //NSCacheのインスタンスを生成しておく。ここに、どんどんキャッシュ化されたものが保存されていく。
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
        //dataはサーバーからの返り値。urlResponseは。HTTPヘッダーやHTTPステータスコードなどの情報。リクエストが失敗したときに、errorに値が入力される。失敗しない限り、nilとなる。
        URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
            
            //errorがnilじゃないということは、リクエストに失敗しているということ。returnで抜け出す。
            if error != nil {
                print(error)
                return
            }
            
            //リクエストが成功して、サーバーからのresponseがある状態。
            //しかし、UIKitのオブジェクトは必ずメインスレッドで実行しなければならないので、DispatchQueue.mainでメインキューに処理を追加する。非同期で登録するので、asyncで実装。
            DispatchQueue.main.async {
                
                //サーバーからのレスポンスのdataを元にして、UIImageを取得し、imageToCacheに代入。
                let imageToCache = UIImage(data:data!)
                
                //self.imageにimageToCacheを代入。
                self.image = imageToCache
                
                //keyをimageUrlStringとして、imageToCacheをキャッシュとして保存する。
                UIImageView.imageCache.setObject(imageToCache!, forKey: imageUrlString as AnyObject)
            }
            }.resume()
    }
}
