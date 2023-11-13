//
//  WeatherController.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import Foundation

class WeatherController: ObservableObject {
    @Published var weatherData: WeatherData?
    @Published var weatherScore: Double = 0.0
    @Published var weatherImageURL: String = ""

    private let weatherAPI = WeatherAPI()

    func fetchWeatherData(latitude: Double, longitude: Double) {
        weatherAPI.fetchWeatherData(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let data):
                self.weatherData = data
                if let weatherData = self.weatherData {
                    self.weatherScore = 0.81 * weatherData.main.temperature + 0.01 * weatherData.main.humidity * (0.99 * weatherData.main.temperature - 14.3) + 46.3 // 3. weatherScore の計算を追加
                    self.weatherImageURL = "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon)@2x.png"
                }
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }

}
