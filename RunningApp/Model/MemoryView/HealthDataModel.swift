//
//  HealthDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/19.
//

import Foundation
import HealthKit

struct HealthDataModel {

    func requestHealthAuthorization(completion: @escaping(Bool) -> Void) {
        let readDataTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        HKHealthStore().requestAuthorization(toShare: nil, read: readDataTypes) { success, _ in
            completion(success)
        }
    }
}
