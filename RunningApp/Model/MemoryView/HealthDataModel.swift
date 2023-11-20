import Foundation
import HealthKit

struct HealthDataModel {
    var stepCounts: [Int] = []

    func requestHealthAuthorization(completion: @escaping (Bool) -> Void) {
        let readDataTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!])
        HKHealthStore().requestAuthorization(toShare: nil, read: readDataTypes) { success, _ in
            completion(success)
        }
    }

    func fetchStepsData(completion: @escaping ([Int]) -> Void) {
        var updatedModel = self  // Create a copy of the model

        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

        let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { _, results, _ in
            guard let statsCollection = results else {
                completion(updatedModel.stepCounts)
                return
            }

            statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                if let quantity = statistics.sumQuantity() {
                    let stepValue = Int(quantity.doubleValue(for: .count()))
                    updatedModel.stepCounts.append(stepValue)
                } else {
                    updatedModel.stepCounts.append(0)
                }
            }

            DispatchQueue.main.async {
                completion(updatedModel.stepCounts)
                print("stepCounts", updatedModel.stepCounts)
            }
        }
        HKHealthStore().execute(query)
    }
}
