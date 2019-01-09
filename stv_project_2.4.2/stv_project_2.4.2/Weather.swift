//
//  Weather.swift
//  stv_project_2.4.2
//
//  Created by 米田大弥 on 2019/01/09.
//  Copyright © 2019 hiroya. All rights reserved.
//

import Foundation

class Forecaster: NSObject {
    
    static func forecast(completion:@escaping (ForecastResult)->Void){
        
        let urlString = "http://weather.livedoor.com/forecast/webservice/json/v1?city=130010"
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
            
            do {
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                print("restgrdgd456754",result)
                completion(result)
            }catch let error{
                print("Error", error)
            }
        }
        task.resume()
    }
}

struct ForecastResult: Codable {
    var forecasts:[ForecastList]
}

struct ForecastList: Codable {
    var dateLabel:String
    var telop:String
    var date:String
}

