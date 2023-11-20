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


    func updateLineData() {
        let today = Date()
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        var date = startOfWeek

        var data: [ChartDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        for _ in 0..<6 {
            _ = calendar.component(.weekday, from: date)
            let dayString = DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
            data.append(ChartDataModel(day: dayString, value: nil)) // You can set the actual values based on your data model
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        chartDataModel = data
    }


    func updateStepLineData(stepCounts: [Int]) {
        var data: [ChartDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"

        for (index, steps) in stepCounts.enumerated() {
            let formattedDate = dateFormatter.string(from: Calendar.current.date(byAdding: .day, value: index, to: Date())!)
            data.append(ChartDataModel(day: formattedDate, value: steps))
        }

        chartDataModel = data
    }

    func onAppearMemoryView() {
        healthDataModel.requestHealthAuthorization { success in
            if success {
                self.healthDataModel.fetchStepsData { stepCounts in
                    self.updateStepLineData(stepCounts: stepCounts)
                }
            }
        }
    }
}
