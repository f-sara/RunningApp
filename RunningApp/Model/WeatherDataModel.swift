//
//  WeatherDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/12.
//

import Foundation

struct WeatherData: Codable {
    let weather: [Weather]
    let main: Main

    struct Weather: Codable {
        let description: String
        let icon: String
    }

    struct Main: Codable {
        let temperature: Double
        let humidity: Double
    }
}
