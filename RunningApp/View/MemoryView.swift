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
            // Additional UI components if needed

            Chart(memoryViewModel.chartDataModel) { dataRow in
                // Your existing chart components
                LineMark(
                    x: .value("曜日", dataRow.day),
                    y: .value("歩数", dataRow.value ?? 0)
                )

                PointMark (
                    x: .value("曜日", dataRow.day),
                    y: .value("歩数", dataRow.value ?? 0)
                )
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
