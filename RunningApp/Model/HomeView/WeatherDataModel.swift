//
//  WeatherDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/12.
//

import Foundation

struct WeatherModel {
    var weatherScore: Double
    var weatherImageURL: String
}

struct WeatherDataModel: Codable {
    let weather: [Weather]
    let main: Main

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temp: Double
        let humidity: Double
    }

}
