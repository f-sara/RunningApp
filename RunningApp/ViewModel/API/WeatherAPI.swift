//
//  WeatherAPI.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/12.
//

import Foundation
import Alamofire

class WeatherAPI {

    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let apiKey = "APIキー"
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"

        AF.request(url).validate().responseDecodable(of: WeatherData.self) { response in
            switch response.result {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

