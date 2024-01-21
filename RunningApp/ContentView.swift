//
//  ContentView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            TabView{
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("ホーム")
                    }

                MemoryView()
                    .tabItem {
                        Image(systemName: "chart.bar.xaxis")
                        Text("記録")
                    }

                PersonalSettingView()
                    .tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("設定")
                    }


            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
