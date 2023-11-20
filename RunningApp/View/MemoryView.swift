//
//  MemoryView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI
import Charts

struct MemoryView: View {
    @ObservedObject var memoryViewModel = MemoryViewModel()

    var body: some View {
        VStack {

            Chart(memoryViewModel.chartDataModel) { dataRow in

                BarMark (
                    x: .value("曜日", dataRow.day),
                    y: .value("歩数", dataRow.value ?? 0)
                )
                .foregroundStyle(.cyan)

                PointMark (
                    x: .value("曜日", dataRow.day),
                    y: .value("歩数", dataRow.value ?? 0)
                )
                .foregroundStyle(.green)

                LineMark(
                    x: .value("曜日", dataRow.day),
                    y: .value("歩数", dataRow.value ?? 0)
                )
                .foregroundStyle(.green)
            }
            .frame(height: 300)
            .onAppear {
                memoryViewModel.onAppearMemoryView()
            }
        }
    }

    struct MemoryView_Previews: PreviewProvider {
        static var previews: some View {
            MemoryView()
        }
    }
}
