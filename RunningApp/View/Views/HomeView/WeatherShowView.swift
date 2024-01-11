//
//  WeatherShowView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/12.
//

import SwiftUI

struct WeatherShowView: View {
    @StateObject var weatherViewModel: WeatherViewModel
    
    var progress: CGFloat {
        guard let weatherScore = weatherViewModel.otherWeatherData?.weatherScore else {return 0.0}
        return CGFloat(weatherScore / 100)
    }

    enum TemperatureOrHumidity {
        case temperature
        case humidity

        var Data: String {
            switch self {
            case .temperature:
                return "-℃"
            case .humidity:
                return "-%"
            }
        }

        var icon: Image {
            switch self {
            case .temperature:
                return Image(systemName: "thermometer.medium")
            case .humidity:
                return Image(systemName: "humidity")
            }
        }

        var text: String {
            switch self {
            case .temperature:
                return "気温"
            case .humidity:
                return "湿度"
            }
        }
    }

    var body: some View {
        CircleView()
            .onAppear {
                weatherViewModel.fetchWeatherData()
            }
    } // body

    func CircleView() -> some View {

        ZStack {
            Circle()
                .fill(Color.white)
                .frame(maxWidth: 231, maxHeight: 231)
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(progressColorSet(score: weatherViewModel.otherWeatherData?.weatherScore))
                .frame(maxWidth: 300, maxHeight: 300)
                .scaledToFit()

            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColorSet(score: weatherViewModel.otherWeatherData?.weatherScore))
                .rotationEffect(Angle(degrees: 270.0))
                .frame(maxWidth: 300, maxHeight: 300)
                .scaledToFit()
            VStack(spacing: 6) {
                AsyncImage(url: URL(string:weatherViewModel.otherWeatherData?.weatherImageURL ?? "")) { image in
                    image
                        .scaledToFit()
                        .frame(maxHeight: 100)
                } placeholder: {
                    ProgressView()
                        .frame(maxHeight: 100)
                }

                HStack(spacing: 0) {
                    VStack(spacing: 5) {
                        temperatureOrHumidityView(tempOrHumidity: .temperature)
                        temperatureOrHumidityView(tempOrHumidity: .humidity)
                    }
                    .frame(width: 80)
                    VStack(alignment: .leading,spacing: 1) {
                        Text("不快指数")
                            .font(.system(size: 14.5))
                            .foregroundColor(Color("darkblue"))
                        if let weatherScore = weatherViewModel.otherWeatherData?.weatherScore {
                            Text(String(format: "%.1f", weatherScore))
                                .font(.system(size: 37))
                                .bold()
                                .foregroundColor(progressColorSet(score: weatherScore))
                        } else {
                            Text("-")
                                .font(.system(size: 37))
                                .bold()
                                .foregroundColor(Color("darkblue"))
                        }
                    }
                    .frame(width: 90)
                }
                .padding(.bottom, 20)
            }
        }
    }

    func progressColorSet(score: Double?) -> Color {
        guard let score = score else {return Color.clear}
        if score < 70 {
            return Color.blue.opacity(0.8)
        } else if score < 75 {
            return Color.green.opacity(0.8)
        } else if score < 80 {
            return Color.yellow
        } else if score < 85 {
            return Color.red.opacity(0.7)
        } else {
            return Color.purple.opacity(0.8)
        }
    }

    func temperatureOrHumidityView(tempOrHumidity: TemperatureOrHumidity) -> some View {
        HStack(spacing: 8){
            tempOrHumidity.icon
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 25,maxHeight: 31)
                .foregroundColor(Color("darkblue"))

            VStack(alignment: .leading,spacing: 4.4) {
                Text(tempOrHumidity.text)
                    .font(.system(size: 9))
                    .foregroundColor(Color("darkblue"))
                if let weatherData = weatherViewModel.weatherData?.main {
                    if tempOrHumidity == .humidity {
                        let ceilHumidity = String(format: "%.0f", weatherData.humidity)
                        Text("\(ceilHumidity)%")
                            .font(.system(size: 17))
                            .bold()
                            .foregroundColor(Color("darkblue"))
                    } else if tempOrHumidity == .temperature {
                        let ceilTemprature = String(format: "%.0f", weatherData.temp)
                        Text("\(ceilTemprature)℃")
                            .font(.system(size: 17))
                            .bold()
                            .foregroundColor(Color("darkblue"))
                    }
                } else {
                    Text(tempOrHumidity.Data)
                        .font(.system(size: 17))
                        .bold()
                        .foregroundColor(Color("darkblue"))
                }

            }
        }
    }
} // struct view

struct WeatherShowView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherShowView(weatherViewModel: WeatherViewModel())
            .previewLayout(.sizeThatFits)
            .frame(maxWidth: 250, maxHeight: 250)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
    }
}
