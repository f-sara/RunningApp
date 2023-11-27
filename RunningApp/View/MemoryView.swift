//
//  MemoryView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI
import Charts

struct MemoryView: View {
    @State private var selectedTab: Int = 0
    @State private var canSwipe: Bool = true
    @State private var dataType = HowData.week

    let list: [String] = ["歩数", "消費カロリー", "移動距離"]

    enum HowData: String, CaseIterable, Identifiable {
        case week = "週"
        case month = "月"
        case year = "年"

        var id: String {rawValue}
    }

    var body: some View {
        ZStack {
            Color.white
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                Picker("データ", selection: $dataType) {
                    ForEach(HowData.allCases) {
                        data in
                        Text(data.rawValue).tag(data)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 30)
                .padding(.top, 20)
                .padding(.bottom, 10)

                TabView(selection: $selectedTab, content: {
                    switch dataType {
                    case .week:
                        ChartView(typeOfData: .step, howData: .week)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(0)
                        ChartView(typeOfData: .kcal, howData: .week)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(1)
                        ChartView(typeOfData: .distance, howData: .week)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(2)
                    case .month:
                        ChartView(typeOfData: .step, howData: .month)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(0)
                        ChartView(typeOfData: .kcal, howData: .month)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(1)
                        ChartView(typeOfData: .distance, howData: .month)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(2)
                    case .year:
                        ChartView(typeOfData: .step, howData: .year)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(0)
                        ChartView(typeOfData: .kcal, howData: .year)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(1)
                        ChartView(typeOfData: .distance, howData: .year)
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .tag(2)
                    }


                })

                TopTabView(list: list, selectedTab: $selectedTab)
                ScrollView {
                    TabView(selection: $selectedTab, content: {
                        ChartDataView(whatData: .step)
                            .tag(0)
                        ChartDataView(whatData: .kcal)
                            .tag(1)
                        ChartDataView(whatData: .distance)
                            .tag(2)


                    })
                }
            }
        }

    }

    struct MemoryView_Previews: PreviewProvider {
        static var previews: some View {
            MemoryView()
                .previewLayout(.sizeThatFits)
        }
    }
}
