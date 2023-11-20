//
//  MemoryViewModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/19.
//

import Foundation

final class MemoryViewModel: ObservableObject {
    @Published var healthDataModel = HealthDataModel()
    @Published var chartDataModel: [ChartDataModel] = []


    func updateLineData(stepCounts: [Int]) {
        let today = Date()
        let calendar = Calendar.current
        let startDay = calendar.date(byAdding: .day, value: -6, to: today)!
        var date = startDay

        var data: [ChartDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"


        for (_, steps) in stepCounts.enumerated() {
            let dayString = dateFormatter.string(from: date)
            data.append(ChartDataModel(day: dayString, value: steps))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        chartDataModel = data
    }

    func onAppearMemoryView() {
        healthDataModel.requestHealthAuthorization { success in
            if success {
                self.healthDataModel.fetchStepsData { stepCounts in
                    self.updateLineData(stepCounts: stepCounts)
                }
            }
        }
    }
}
