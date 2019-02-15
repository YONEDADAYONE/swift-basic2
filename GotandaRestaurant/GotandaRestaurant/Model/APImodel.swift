//
//  APImodel.swift
//  GotandaRestaurant
//
//  Created by 米田大弥 on 2019/02/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class Forecaster: NSObject {
    
    static func forecast(completion: @escaping (ForecastResult) -> Void) {
        
        let urlString = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
            
            do {
                let result: ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                print("エラーがなければ結果は→", result)
                completion(result)
            } catch let error {
                print("エラーになればここで止まる。", error)
            }
        }
        task.resume()
    }
}

//最重要　Codableを利用する際は必ず変数名はAPIのサイト通りに必ずしなければならない！
struct ForecastResult: Codable {
    //超重要　変数名はAPIのサイト通りに必ずしなければならない
    var forecasts: [ForecastList]
    var description: DescriptionList
}

//区別するためにForecastにListを加え、ForecastListにした
struct ForecastList: Codable {
    //超重要 この変数も必ずAPIのサイト通りにすること!
    var dateLabel: String //日付
    var date: String //予報日
    var telop: String //天気
    var image: Image
    
    //当初のクラス名はImageの「I」が小文字の「i」だったがswiftLintの指摘により訂正
    struct Image: Codable {
        var url: String
    }
    
}

struct DescriptionList: Codable {
    var text: String
}
