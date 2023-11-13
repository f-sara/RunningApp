//
//  WeatherShowView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/12.
//

import SwiftUI

struct WeatherShowView: View {
    @State var weatherData: WeatherData?
    @State var weatherScore: Double = 0.0
    @State var weatherImageURL: String = ""
    private let latitude = 35.6895
    private let longitude = 139.6917

    private let weatherController = WeatherController()

    var progressColor: Color {
        if weatherScore < 70 {
            return Color.blue.opacity(0.8)
        } else if weatherScore < 75 {
            return Color.green.opacity(0.8)
        } else if weatherScore < 80 {
            return Color.yellow
        } else if weatherScore < 85 {
            return Color.red.opacity(0.7)
        } else {
            return Color.purple.opacity(0.8)
        }
    }

    enum temperatureOrHumidity {
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

    @State public var progress: CGFloat

    var body: some View {
        CircleView()
            .onAppear {
                weatherController.fetchWeatherData(latitude: latitude, longitude: longitude)
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
                .foregroundColor(progressColor)
                .frame(maxWidth: 300, maxHeight: 300)
                .scaledToFit()

            Circle()
                .trim(from: 0.0, to: min(progress, 1.0))
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor)
                .rotationEffect(Angle(degrees: 270.0))
                .frame(maxWidth: 300, maxHeight: 300)
                .scaledToFit()
            VStack(spacing: 6) {
                AsyncImage(url: URL(string: weatherImageURL)) { image in
                    image
                        .scaledToFit()
                        .frame(maxHeight: 100)
                } placeholder: {
                    ProgressView()
                        .frame(maxHeight: 100)
                }

                HStack(spacing: 19) {
                    VStack(spacing: 8) {
                        temperatureOrHumidityView(tempOrHumidity: .temperature)
                        temperatureOrHumidityView(tempOrHumidity: .humidity)
                    }
                    VStack(alignment: .leading,spacing: 1) {
                        Text("不快指数")
                            .font(.system(size: 14.5))
                            .foregroundColor(Color("darkblue"))
                        if weatherScore != 0.0 {
                            Text(String(format: "%.1f", weatherScore))
                                .font(.system(size: 37))
                                .bold()
                                .foregroundColor(progressColor)
                        } else {
                            Text("-")
                                .font(.system(size: 37))
                                .bold()
                                .foregroundColor(Color("darkblue"))
                        }
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
    func temperatureOrHumidityView(tempOrHumidity: temperatureOrHumidity) -> some View {
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
                if let weatherData = weatherData {
                    if tempOrHumidity == .humidity {
                        let ceilHumidity = String(format: "%.0f", weatherData.main.humidity)
                        Text("\(ceilHumidity)%")
                            .font(.system(size: 17))
                            .bold()
                            .foregroundColor(Color("darkblue"))
                    } else if tempOrHumidity == .temperature {
                        let ceilTemprature = String(format: "%.0f", weatherData.main.temperature)
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
        WeatherShowView(progress: 0.744)
            .previewLayout(.sizeThatFits)
            .frame(maxWidth: 250, maxHeight: 250)
            .padding(.horizontal, 20)
            .padding(.vertical, 20)
    }
}
