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
    @State var reatStep: String = "400"

    var body: some View {

        ZStack{
            Color("white2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 0) {
                WeatherShowView(weatherViewModel: WeatherViewModel())
                    .frame(maxWidth: 230, maxHeight: 230)
                    .padding(.top, 7)
                    .padding(.bottom, 15)
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
                        }
                    } // 今日の記録

                    HStack(spacing: 14) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 168, height: 170)

                            VStack(spacing: 10) {
                                Text("目標まで")
                                    .padding(.trailing, 75)
                                    .font(.system(size: 19))
                                    .foregroundColor(.black.opacity(0.7))
                                HStack(spacing: 10) {
                                    Text("あと")
                                        .foregroundColor(.black.opacity(0.7))
                                    Text(reatStep)
                                        .bold()
                                        .font(.system(size: 40))
                                    Text("歩")
                                }
                                HStack(spacing: 5) {
                                    Text("目標を変更する")
                                        .foregroundColor(Color("red"))
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(Color("red"))
                                }
                            }


                        }
                        .frame(width: 168, height: 170)

                        ZStack {
                            RoundedRectangle(cornerRadius: 15, style: .continuous)
                                .fill(Color.white)
                                .frame(width: 168, height: 170)

                        }
                        .frame(width: 168, height: 170)

                    }
                    .padding(.bottom, 15)

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

                    Spacer()
                }

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
