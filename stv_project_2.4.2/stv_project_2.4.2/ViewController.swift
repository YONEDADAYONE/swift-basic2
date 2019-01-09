//
//  ViewController.swift
//  stv_project_2.4.2
//
//  Created by 米田大弥 on 2019/01/04.
//  Copyright © 2019 hiroya. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var forecasts = [ForecastList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Forecaster.forecast { (result) in
            self.forecasts = result.forecasts
            print(self.forecasts)
        }
    }
    
    
    }
    
//    func getweather() {
//        //お天気APIから東京の天気を取得する
//        Alamofire.request("http://weather.livedoor.com/forecast/webservice/json/v1?city=130010").responseJSON {response in
//
//            let json: JSON = JSON(response.value ?? kill) //killは三項演算子
//
//            let forecasts = json["forecasts"]
//            let image = forecasts["dateLabel"]
////            print(forecasts)
////            print("image = \(image)")
//
//        //ここからアクションシート
//            let alert: UIAlertController =
//                UIAlertController(title: "お天気情報です",
//                                  message: "どれにしますか？",
//                                  preferredStyle: UIAlertController.Style.actionSheet)
//
//            let todayActionsheet: UIAlertAction =
//                UIAlertAction(title: "今日",
//                              style: UIAlertAction.Style.default,
//                              handler: {(_: UIAlertAction) in
//                //ここに処理を記載(今日の天気の情報)
//
//                })
//}
//}




//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //天気のAPIにアクセスし、APIの結果をJSONで取得
//        let str : String = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
//        let url : URL = URL(string: str)!
//        // URLRequestを生成してJSONのデータを取得
//        let request: URLRequest = URLRequest(url:url)
//        let session = URLSession.shared
//        let task : URLSessionDataTask = session.dataTask(with: request, completionHandler: {(data, response, error) in
//
//            // APIからの戻り値がなければ処理を終了
//            guard let data = data else{ return }
//
//            // エラーがあれば表示
//            if(error != nil) {
//                print(error ?? "")
//                return
//            }
//            print(data)
//            do{
//                // JSONDecoderクラスのインスタンスを生成
//                let decoder = JSONDecoder()
//                // JSONを解析して作成した構造体の通りにマッピング
//                let resultList = try? decoder.decode(ResultList.self, from: data)
//                print(resultList)
//
////                // JSONを解析した後、User構造体にマッピングされたデータを取り出す
////                for user in (resultList?.results)! {
////                }
//
//            }catch{
//                print("JSONの解析でエラーが起きました")
//            }
//        })
//        task.resume()
//    }
//
//    // resultsを格納する構造体
//    struct ResultList:Codable{
//        let results : [Weather]
//    }
//
//    // ユーザー情報を格納す構造体
//    struct Weather: Codable  {
//
//        let forecasts: Name
//        struct Name: Codable  {
//            let datelabel: String
//            let telop: String
//            let date: String
//        }
//    }
//
//}
