//
//  HomeView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/10/26.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var showSheet: Bool = false
    @State private var locationManager = CLLocationManager()
    let viewModel = HomeHealthViewModel()

    @State private var stepText: String = ""
    @State private var kcalText: String = ""
    @State private var distanceText: String = ""
    @State private var restStep: String = ""

    @State private var restWalkingMinute: String = "   "
    @State private var restRunningMinute: String = "   "
    @State private var appMode: String = "ランニングモード"
    @State private var stepGoal: Int = 7000

    enum AppMode {
        case running
        case walking

        var text: String {
            switch self {
            case .running:
                return "走ってみましょう"
            case .walking:
                return "歩いてみましょう"
            }
        }
    }

    var body: some View {

        ZStack{
            Color("testcolor")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0) {
                WeatherShowView(weatherViewModel: WeatherViewModel())
                    .frame(maxWidth: 230, maxHeight: 230)
                    .padding(.top, 9)
                    .padding(.bottom, 18)
                VStack(spacing: 0) {
                    // 今日の記録
                    ZStack {
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color.orange)
                            .frame(width: 350, height: 155)

                        VStack(spacing: 5) {
                            Text("今日の記録")
                                .padding(.trailing, 235)
                                .padding(.top, 7)
                                .font(.system(size: 19))
                                .foregroundColor(Color.white.opacity(0.9))
                            HStack(spacing: 0) {
                                TodayRecordView(icon: "figure.walk", data: stepText, title: "歩数")
                                TodayRecordView(icon: "flame", data: kcalText, title: "消費カロリー(kcal)")
                                TodayRecordView(icon: "location", data: distanceText, title: "推定歩行距離(km)")

                            }
                            .padding(.bottom, 2)
                        }
                        .frame(width: 350, height: 155)
                    }
                    .padding(.bottom, 10)
                    .onAppear{
                        locationManager.requestWhenInUseAuthorization()
                        viewModel.onAppearHomeView()
                        NotificationCenter.default.addObserver(
                            forName: .processDidFinish,
                            object: nil,
                            queue: .main
                        ) { notification in
                            appMode = UserDefaults.standard.string(forKey: "appMode") ?? "ランニングモード"
                            stepGoal = UserDefaults.standard.integer(forKey: "stepGoal")
                            stepText = viewModel.todayStepData
                            print("stepText", viewModel.todayStepData)
                            kcalText = viewModel.todayKcalData
                            distanceText = viewModel.todayDistanceData
                            restStep = String(stepGoal - (Int(viewModel.todayStepData) ?? 0))
                            restWalkingMinute = String(Int(round(0.8 * (Double(restStep) ?? 0) / 60)))
                            restRunningMinute = String(Int(round(0.5 * (Double(restStep) ?? 0) / 60)))
                            print("残り\(restWalkingMinute)")
                        }
                    } // 今日の記録終わり

                    if Int(restStep) ?? 1 < 0 {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 350, height: 170)

                            VStack(spacing: 0) {
                                Text("今日の目標を達成しました")
                                    .padding(.top, 8)
                                    .font(.system(size: 23))
                                    .foregroundColor(.black.opacity(0.7))
                                    .padding(.top, 12)
                                    .bold()

                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color("background"))
                                        .frame(width: 175, height: 70)

                                    VStack(spacing: 5) {
                                        Text("今日はお疲れ様でした！")
                                            .font(.system(size: 14))
                                        Text("明日も頑張りましょう！")
                                            .font(.system(size: 14))
                                    }

                                }
                                .frame(width: 180, height: 85)
                                .padding(.leading, 130)
                                .padding(.bottom, 5)

                                HStack(spacing: 5) {
                                    Text("目標を変更する")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("red"))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color("red"))
                                }
                                .padding(.bottom, 26)
                                .padding(.leading, 200)

                            }
                            Image("think2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 90)
                                .padding(.top, 70)
                                .padding(.bottom, 20)
                                .padding(.trailing, 195)
                        }
                        .frame(width: 350, height: 170)
                        .padding(.bottom, 10)
                    } else {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 350, height: 170)

                            VStack(spacing: 0) {
                                HStack(spacing: 4) {
                                    Text("目標まであと")
                                        .padding(.top, 15)
                                        .font(.system(size: 19))
                                        .foregroundColor(.black.opacity(0.7))
                                    Text(restStep)
                                        .bold()
                                        .font(.system(size: 35))
                                        .frame(width: 100, height: 50)
                                    Text("歩")
                                        .font(.system(size: 19))
                                        .padding(.top, 15)
                                        .foregroundColor(.black.opacity(0.7))
                                }
                                .padding(.top, 12)

                                ZStack {
                                    RoundedRectangle(cornerRadius: 8, style: .continuous)
                                        .fill(Color("background"))
                                        .frame(width: 175, height: 70)

                                    VStack(spacing: 1) {
                                        HStack(spacing: 4) {
                                            if appMode == "ランニングモード" {
                                                Text("あと\(restRunningMinute)分ほど")
                                                    .font(.system(size: 17))
                                            } else {
                                                Text("あと\(restWalkingMinute)分ほど")
                                                    .font(.system(size: 17))
                                            }


                                        }
                                        .padding(.trailing, 30)
                                        if appMode == "ランニングモード" {
                                            Text(AppMode.running.text)
                                                .padding(.leading, 26)
                                                .font(.system(size: 17))
                                        } else {
                                            Text(AppMode.walking.text)
                                                .padding(.leading, 26)
                                                .font(.system(size: 17))
                                        }

                                    }
                                }
                                .frame(width: 180, height: 85)
                                .padding(.leading, 130)
                                .padding(.bottom, 5)

                                HStack(spacing: 5) {
                                    Text("目標を変更する")
                                        .font(.system(size: 14))
                                        .foregroundColor(Color("red"))
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 15))
                                        .foregroundColor(Color("red"))
                                }
                                .padding(.bottom, 26)
                                .padding(.leading, 200)

                            }
                            Image("think2")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 130, height: 90)
                                .padding(.top, 70)
                                .padding(.bottom, 20)
                                .padding(.trailing, 195)
                        }
                        .frame(width: 350, height: 170)
                        .padding(.bottom, 10)
                    }



                    Button {
                        showSheet.toggle()
                    } label: {
                        StartButtonView()
                            .background(
                                Color.gray.opacity(0.8)
                                    .cornerRadius(5)
                                    .shadow(color: Color.gray, radius: 2, x: 0, y: 3)
                            )
                    }
                    .sheet(isPresented: $showSheet) {
                        CheckView()
                    }

                }
                Spacer()

            }
            .navigationTitle("ホーム")
        }

    }

}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
