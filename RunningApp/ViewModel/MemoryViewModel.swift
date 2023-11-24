//
//  MemoryViewModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/19.
//

import Foundation

final class MemoryViewModel: ObservableObject {
    @Published var healthDataModel = HealthDataModel()
    @Published var stepDataModel: [ChartDataModel.StepDataModel] = []
    @Published var kcalDataModel: [ChartDataModel.KcalDataModel] = []
    @Published var distanceDataModel: [ChartDataModel.DistanceDataModel] = []

    func updateStepData(stepCounts: [Int]) {
        let today = Date()
        let calendar = Calendar.current
        let startDay = calendar.date(byAdding: .day, value: -6, to: today)!
        var date = startDay

        var data: [ChartDataModel.StepDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"


        for (_, steps) in stepCounts.enumerated() {
            let dayString = dateFormatter.string(from: date)
            data.append(ChartDataModel.StepDataModel(day: dayString, step: steps))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        stepDataModel = data
    }

    func updateKcalData(kcalData: [Double]) {
        let today = Date()
        let calendar = Calendar.current
        let startDay = calendar.date(byAdding: .day, value: -6, to: today)!
        var date = startDay

        var data: [ChartDataModel.KcalDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"


        for (_, kcal) in kcalData.enumerated() {
            let dayString = dateFormatter.string(from: date)
            data.append(ChartDataModel.KcalDataModel(day: dayString, kcal: kcal))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        kcalDataModel = data
    }

    func updateDistanceData(distanceData: [Double]) {
        let today = Date()
        let calendar = Calendar.current
        let startDay = calendar.date(byAdding: .day, value: -6, to: today)!
        var date = startDay

        var data: [ChartDataModel.DistanceDataModel] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"


        for (_, distance) in distanceData.enumerated() {
            let dayString = dateFormatter.string(from: date)
            data.append(ChartDataModel.DistanceDataModel(day: dayString, distance: distance))
            date = calendar.date(byAdding: .day, value: 1, to: date)!
        }

        distanceDataModel = data
    }
    

    func onAppearStepMemoryView() {
        healthDataModel.requestHealthAuthorization { success in
            if success {
                self.healthDataModel.fetchStepsData { result in
                    switch result {
                    case .success(let stepCounts):
                        self.updateStepData(stepCounts: stepCounts)
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                print("アクセスが許可されていません")
            }
        }
    }

    func onAppearKcalMemoryView() {
        healthDataModel.requestHealthAuthorization { success in
            if success {
                self.healthDataModel.fetchKcalData { result in
                    switch result {
                    case .success(let kcal):
                        self.updateKcalData(kcalData: kcal)
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                print("アクセスが許可されていません")
            }
        }
    }

    func onAppearDistanceMemoryView() {
        healthDataModel.requestHealthAuthorization { success in
            if success {
                self.healthDataModel.fetchDistanceData { result in
                    switch result {
                    case .success(let distance):
                        self.updateDistanceData(distanceData: distance)
                    case .failure(let error):
                        print(error)
                    }
                }
            } else {
                print("アクセスが許可されていません")
            }
        }
    }

}


