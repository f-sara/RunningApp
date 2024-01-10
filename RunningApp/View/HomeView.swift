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
            Color("white")
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
                                    .fill(Color("green"))
                                    .frame(width: 360, height: 155)

                                VStack(spacing: 5) {
                                    Text("今日の記録")
                                        .padding(.trailing, 235)
                                        .padding(.top, 7)
                                        .font(.system(size: 19))
                                    HStack(spacing: 0) {
                                        VStack(spacing: 6) {
                                            Image(systemName: "figure.walk")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 20)
                                                .foregroundColor(Color.black.opacity(0.6))
                                            Text(stepText)
                                                .font(.system(size: 30))
                                                .bold()
                                                .frame(height: 40)
                                            Text("歩数")
                                                .font(.system(size: 13))
                                        }
                                        .frame(width: 120, height: 110)

                                        VStack(spacing: 6) {
                                            Image(systemName: "flame")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 20)
                                                .foregroundColor(Color.black.opacity(0.6))

                                            Text(kcalText)
                                                .font(.system(size: 30))
                                                .bold()
                                                .frame(height: 40)
                                            Text("消費カロリー")
                                                .font(.system(size: 13))
                                        }
                                        .frame(width: 120)

                                        VStack(spacing: 6) {
                                            Image(systemName: "location")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 20)
                                                .foregroundColor(Color.black.opacity(0.6))
                                            Text(distanceText)
                                                .font(.system(size: 30))
                                                .bold()
                                                .frame(height: 40)
                                            Text("移動距離")
                                                .font(.system(size: 13))
                                        }
                                        .frame(width: 120)


                                    }
                                    .padding(.bottom, 5)

                                }
                                .frame(width: 360, height: 155)
                            }
                            .padding(.all, 10)
                            .onAppear{
                                locationManager.requestWhenInUseAuthorization()
                                DispatchGroup().enter()
                                homeHealthViewModel.onAppearHomeView()
                                DispatchGroup().notify(queue: .main) {
                                    stepText = homeHealthViewModel.todayStepData
                                    print("stepText", homeHealthViewModel.todayStepData)
                                    kcalText = homeHealthViewModel.todayKcalData
                                    distanceText = homeHealthViewModel.todayDistanceData
                                }
                            } // 今日の記録

                            HStack {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .fill(Color("grd1"))
                                        .frame(width: 175, height: 180)

                                }
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                                        .fill(Color("grd2"))
                                        .frame(width: 175, height: 185)

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
