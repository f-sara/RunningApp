//
//  ChartDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/20.
//

import Foundation

struct ChartDataModel {
    struct StepDataModel: Identifiable {
        var id = UUID()
        var day: String
        var step: Int?
    }

    struct KcalDataModel: Identifiable {
        var id = UUID()
        var day: String
        var kcal: Double?
    }

    struct DistanceDataModel: Identifiable {
        var id = UUID()
        var day: String
        var distance: Double?
    }
}
