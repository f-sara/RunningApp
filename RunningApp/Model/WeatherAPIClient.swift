//
//  WeatherAPIClient.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/17.
//

import Foundation
import Alamofire

struct WeatherAPIClient {
    let apiKey = "APIキー"
    let baseURL: URL? = URL(string: "https://api.openweathermap.org/data/2.5/weather")
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherDataModel, WeatherAPIError>) -> Void) {
        var urlComponents = URLComponents(
          url: baseURL!,
          resolvingAgainstBaseURL: true
        )

        urlComponents?.queryItems = [
            URLQueryItem(name: "lat", value: latitude.description),
            URLQueryItem(name: "lon", value: longitude.description),
            URLQueryItem(name: "appid", value: apiKey),
            URLQueryItem(name: "units", value: "metric")
        ]

        guard let url = urlComponents?.url else {
            completion(.failure(WeatherAPIError.failBuildURL))
            return
        }

        AF.request(url).validate().responseDecodable(of: WeatherDataModel.self) { response in
            switch response.result {
            case .success(let weatherData):
                completion(.success(weatherData))
            case .failure(let error):
                completion(.failure(WeatherAPIError.afError(error)))
            }
        }
    }
}

enum WeatherAPIError: Error {
    case failBuildURL
    case afError(AFError)

}
