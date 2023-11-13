//
//  HomeMemoryView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct HomeMemoryView: View {

    var whenThisData: whenData
    var workThisLevel: workLevel

    enum whenData {
        case today
        case beforeDay

        var text: String {
            switch self {
            case .today:
                return "今日の記録"
            case .beforeDay:
                return "前回の記録"
            }
        }

        var workData: CGFloat {
            switch self {
            case .today:
                return 0.0
            case .beforeDay:
                return 0.8
            }
        }

        var distanceData: String {
            switch self {
            case .today:
                return "-km"
            case .beforeDay:
                return "1.4km"
            }
        }

        var kcal: String {
            switch self {
            case .today:
                return "-"
            case .beforeDay:
                return "140"
            }
        }

        var step: String {
            switch self {
            case .today:
                return "-"
            case .beforeDay:
                return "1400"
            }
        }
    }

    enum workLevel {
        case notMax
        case max

        var color: Color {
            switch self {
            case .notMax:
                return Color.pink
            case .max:
                return Color.yellow
            }
        }
    }

    enum whatWork {
        case cal
        case steps

        var image: Image {
            switch self {
            case .cal:
                return Image(systemName: "flame")
            case .steps:
                return Image(systemName: "figure.walk")

            }
        }
        var unit: String {
            switch self {
            case .cal:
                return "kcal"
            case .steps:
                return "歩"
            }
        }
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
            VStack(spacing: 24) {
                Text(whenThisData.text)
                    .font(.system(size:22))
                VStack(spacing: 18) {
                    // グラフ
                    ZStack{
                        Circle()
                            .stroke(lineWidth: 13)
                            .opacity(0.3)
                            .foregroundColor(workThisLevel.color)
                            .frame(width: 90, height: 90)
                            .scaledToFit()

                        Circle()
                            .trim(from: 0.0, to: min(whenThisData.workData, 1.0))
                            .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                            .foregroundColor(workThisLevel.color)
                            .rotationEffect(Angle(degrees: 270.0))
                            .frame(width: 90, height: 90)
                            .scaledToFit()
                        Text(whenThisData.distanceData)
                            .font(.system(size: 25))
                            .bold()
                    } // ZStack
                    // 記録データ
                    VStack(alignment: .leading) {
                        whatMemoryData(whatWork: .cal, whenData: whenThisData)
                            .padding(.bottom, 10)
                        whatMemoryData(whatWork: .steps, whenData: whenThisData)
                    }
                } // HStack
            } // VStack
        } // ZStack
        .frame(width: 156, height: 350)
    } // body

    func whatMemoryData(whatWork: whatWork, whenData: whenData) -> some View{
        VStack(alignment: .leading) {
            whatWork.image
                .resizable()
                .scaledToFit()
                .frame(height: 25)
                .foregroundColor(Color.green)
            if whatWork == .cal {
                Text(whenData.kcal + whatWork.unit)
                    .font(.system(size: 23))
                    .bold()
            } else {
                Text(whenData.step + whatWork.unit)
                    .font(.system(size: 23))
                    .bold()
            }
        }
    }
}

struct HomeMemoryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeMemoryView(whenThisData: .beforeDay, workThisLevel: .max)
            HomeMemoryView(whenThisData: .today, workThisLevel: .notMax)
        }
        .previewLayout(.sizeThatFits)
        .padding(.all, 20)
    }
}

