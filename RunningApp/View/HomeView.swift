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
    var homeHealthViewModel = HomeHealthViewModel()

    @State var stepText: String = ""
    @State var kcalText: String = ""
    @State var distanceText: String = ""
    @State var restStep: String = ""
    @State var restMinute: String = "　　"

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
                        homeHealthViewModel.onAppearHomeView()
                        NotificationCenter.default.addObserver(
                            forName: .processDidFinish,
                            object: nil,
                            queue: .main
                        ) { notification in
                            stepText = homeHealthViewModel.todayStepData
                            print("stepText", homeHealthViewModel.todayStepData)
                            kcalText = homeHealthViewModel.todayKcalData
                            distanceText = homeHealthViewModel.todayDistanceData
                            restStep = String(7000 - (Int(homeHealthViewModel.todayStepData) ?? 0))
                            restMinute = String(Int(round(0.8 * (Double(restStep) ?? 0) / 60)))
                            print("残り\(restMinute)")
                        }
                    } // 今日の記録終わり

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
                                        Text("あと\(restMinute)分ほど")
                                            .font(.system(size: 17))

                                    }
                                    .padding(.trailing, 30)
                                    Text("歩いてみましょう")
                                        .padding(.leading, 26)
                                        .font(.system(size: 17))
                                }
                            }
                            .frame(width: 180, height: 85)
                            .padding(.leading, 130)
                            .padding(.bottom, 5)

                            HStack(spacing: 5) {
                                Text("目標を変更する")
                                    .font(.system(size: 14))
                                    .bold()
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
