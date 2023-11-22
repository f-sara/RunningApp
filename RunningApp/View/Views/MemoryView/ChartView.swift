//
//  ChartView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/20.
//

import SwiftUI
import Charts

struct ChartView: View {
    @ObservedObject var memoryViewModel = MemoryViewModel()
    @State var typeOfData: TypeOfData

    enum TypeOfData {
        case step
        case kcal
        case distance

        var dataName: String {
            switch self {
            case .step:
                return "歩数"
            case .kcal:
                return "消費カロリー"
            case .distance:
                return "移動距離"
            }
        }


    }
    

    var body: some View {
        ZStack {
            Color(.white)
                .frame(width: 380, height: 300)

            switch typeOfData {
            case .step:
                Chart(memoryViewModel.stepDataModel) { dataRow in

                    PointMark (
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.step ?? 0)
                    )
                    .foregroundStyle(.green)

                    LineMark(
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.step ?? 0)
                    )
                    .foregroundStyle(.green)
                }
                .frame(width: 320, height: 240)
                .onAppear {
                    memoryViewModel.onAppearStepMemoryView()
                }

            case .kcal:
                Chart(memoryViewModel.kcalDataModel) { dataRow in

                    PointMark (
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.kcal ?? 0)
                    )
                    .foregroundStyle(.green)

                    LineMark(
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.kcal ?? 0)
                    )
                    .foregroundStyle(.green)
                }
                .frame(width: 320, height: 240)
                .onAppear {
                    memoryViewModel.onAppearKcalMemoryView()
                }
                
            case .distance:
                Chart(memoryViewModel.distanceDataModel) { dataRow in

                    PointMark (
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.distance ?? 0)
                    )
                    .foregroundStyle(.green)

                    LineMark(
                        x: .value("曜日", dataRow.day),
                        y: .value(typeOfData.dataName, dataRow.distance ?? 0)
                    )
                    .foregroundStyle(.green)
                }
                .frame(width: 320, height: 240)
                .onAppear {
                    memoryViewModel.onAppearDistanceMemoryView()
                }
            }


        }
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ChartView(typeOfData: .step)
            ChartView(typeOfData: .kcal)
            ChartView(typeOfData: .distance)
        }
        .previewLayout(.sizeThatFits)
    }
}
