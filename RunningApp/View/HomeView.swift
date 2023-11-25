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

    var body: some View {
        ZStack{
            Color("white")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)

            VStack {
                WeatherShowView(weatherViewModel: WeatherViewModel())
                    .frame(maxWidth: 250, maxHeight: 250)
                    .padding(.all, 30)

                ZStack {

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
                    .padding(.top, 250)
                    .sheet(isPresented: $showSheet) {
                        CheckView()
                    }
                }

            }
            .navigationTitle("ホーム")
        }
        .onAppear{
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
