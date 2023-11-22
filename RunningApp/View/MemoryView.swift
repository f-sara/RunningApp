//
//  MemoryView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI
import Charts

struct MemoryView: View {

    enum DataType: String, CaseIterable, Identifiable {
        case step = "歩数"
        case kcal = "消費カロリー"
        case distance = "移動距離"

        var id: String {rawValue}
    }


    @State private var dataType = DataType.step

    var body: some View {
        ZStack {
            Color("white")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
            
            VStack(spacing: 0) {
                Picker("データ", selection: $dataType) {
                    ForEach(DataType.allCases) {
                        data in
                        Text(data.rawValue).tag(data)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.all, 30)

                ScrollView {
                    VStack{
                        if dataType == .step {
                            ChartView(typeOfData: .step)
                                .padding(.horizontal, 20)
                                .padding(.top, 3)
                        } else if dataType == .kcal {
                            ChartView(typeOfData: .kcal)
                                .padding(.horizontal, 20)
                                .padding(.top, 3)
                        } else if dataType == .distance {
                            ChartView(typeOfData: .distance)
                                .padding(.horizontal, 20)
                                .padding(.top, 3)
                        }
                    }
                }
            }
        }

    }

    struct MemoryView_Previews: PreviewProvider {
        static var previews: some View {
            MemoryView()
        }
    }
}
