//
//  HomeView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/10/26.
//

import SwiftUI

struct HomeView: View {
    @State var showSheet: Bool = false
    var body: some View {
        ZStack{
            Color("white")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)

            VStack {
                WeatherShowView(progress: 0.744)
                    .frame(maxWidth: 250, maxHeight: 250)
                    .padding(.all, 30)

                ZStack {
                    ScrollView {
                        HStack(spacing: 21){
                            HomeMemoryView(whenThisData: .beforeDay, workThisLevel: .max)
                            HomeMemoryView(whenThisData: .today, workThisLevel: .notMax)
                        }
                    }

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
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
