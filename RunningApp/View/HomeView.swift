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

    var body: some View {

        ZStack{
            Color("white2")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)

            VStack(spacing: 0) {
                WeatherShowView(weatherViewModel: WeatherViewModel())
                    .frame(maxWidth: 240, maxHeight: 240)
                    .padding(.all, 25)

                ZStack {
                    ScrollView {
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
                                        TodayRecordView(icon: "location", data: distanceText, title: "移動距離(km)")

                                    }
                                    .padding(.bottom, 2)

                                }
                                .frame(width: 350, height: 155)
                            }
                            .padding(.all, 10)
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
                                        .frame(width: 168, height: 180)

                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .fill(Color.white)
                                        .frame(width: 168, height: 185)

                                }

                            }


                        } // VStack
                    } // ScrollView

                    Button {
                        showSheet.toggle()
                    } label: {
                        StartButtonView()
                            .background(
                                Color.gray.opacity(0.8)
                                    .cornerRadius(90)
                                    .shadow(color: Color.gray, radius: 3, x: 1.5, y: 1.5)
                            )
                    }
                    .sheet(isPresented: $showSheet) {
                        CheckView()
                    }
                    .padding(.top, 283)
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
