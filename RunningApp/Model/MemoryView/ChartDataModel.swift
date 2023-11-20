//
//  ChartDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/20.
//

import Foundation

struct ChartDataModel: Identifiable {
    var id = UUID()
    var day: String
    var value: Int?
    
}
