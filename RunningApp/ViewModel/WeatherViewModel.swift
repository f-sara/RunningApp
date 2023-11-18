//
//  WeatherViewModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import Foundation

final class WeatherViewModel: ObservableObject {

    @Published var weatherData: WeatherDataModel?

    private let weatherAPIClient = WeatherAPIClient()

    private let latitude = 35.6895
    private let longitude = 139.6917

    var otherWeatherData: WeatherModel? {
        guard let weatherData = weatherData else {return nil}

        return WeatherModel.init(weatherScore: 0.81 * weatherData.main.temp + 0.01 * weatherData.main.humidity * (0.99 * weatherData.main.temp - 14.3) + 46.3, weatherImageURL: "https://openweathermap.org/img/wn/\(weatherData.weather[0].icon)@2x.png")
    }

    func fetchWeatherData() {
        weatherAPIClient.fetchWeatherData(latitude: latitude, longitude: longitude) { result in
            switch result {
            case .success(let data):
                self.weatherData = data
            case .failure(let error):
                print("API Error: \(error)")
            }
        }
    }

}
