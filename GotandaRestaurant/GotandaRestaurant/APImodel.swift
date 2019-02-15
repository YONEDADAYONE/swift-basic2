//
//  APImodel.swift
//  GotandaRestaurant
//
//  Created by 米田大弥 on 2019/02/15.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class RestaurantAPI: NSObject {
    
    static func restaurant(completion: @escaping (RestaurantResult) -> Void) {
        
        let urlString = "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=65d8725723ef2c21&large_area=Z011&format=json"
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
                let result: RestaurantResult = try JSONDecoder().decode(RestaurantResult.self, from: jsonData)
                print("エラーがなければ結果は→", result)
                completion(result)
            } catch let error {
                print("エラーになればここで止まる。", error)
            }
        }
        task.resume()
    }
}

//Codableを利用する際は必ず変数名はAPIのサイト通りに必ずしなければならない。
struct RestaurantResult: Codable {
    //この変数名はAPIのサイト通りに必ずしなければならない
    var results: [ResultsList]
}

//区別するためにForecastにListを加え、ForecastListにした
struct ResultsList: Codable {
    
    var shop: shop
    
    struct shop: Codable {
        var name_kana: String
        var other_memo: String
    }
    
}

