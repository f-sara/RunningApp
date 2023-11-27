//
//  HealthDataModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/19.
//

import Foundation
import HealthKit

struct HealthDataModel {
    var stepCounts: [Int] = []
    var kcalData: [Double] = []
    var distanceData: [Double] = []

    enum HowData {
        case week
        case month
        case year
    }

    func requestHealthAuthorization(completion: @escaping (Bool) -> Void) {
        let readDataTypes = Set([HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                 HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                 HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!])
        HKHealthStore().requestAuthorization(toShare: nil, read: readDataTypes) { success, _ in
            completion(success)
        }
    }

    func fetchStepsWeekData(completion: @escaping (Result<[Int], Error>) -> Void) {
        var updatedModel = self

        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

        let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { _, results, error in
            guard let statsCollection = results else {
                if let error = error {
                    completion(.failure(error))
                }
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
                completion(.success(updatedModel.stepCounts))
                print("stepCounts", updatedModel.stepCounts)
            }
        }
        HKHealthStore().execute(query)
    }

    func fetchStepsMonthData(completion: @escaping (Result<[Int], Error>) -> Void) {
        var updatedModel = self

        let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
        let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

        let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { _, results, error in
            guard let statsCollection = results else {
                if let error = error {
                    completion(.failure(error))
                }
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
                completion(.success(updatedModel.stepCounts))
                print("stepCounts", updatedModel.stepCounts)
            }
        }
        HKHealthStore().execute(query)
    }

    func fetchStepsYearData(completion: @escaping (Result<[Int], Error>) -> Void) {
        var updatedModel = self

        let oneWeekAgo = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
        let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

        let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .stepCount)!,
                                                quantitySamplePredicate: predicate,
                                                options: .cumulativeSum,
                                                anchorDate: startDate,
                                                intervalComponents: DateComponents(day: 1))

        query.initialResultsHandler = { _, results, error in
            guard let statsCollection = results else {
                if let error = error {
                    completion(.failure(error))
                }
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
                completion(.success(updatedModel.stepCounts))
                print("stepCounts", updatedModel.stepCounts)
            }
        }
        HKHealthStore().execute(query)
    }

    func fetchKcalWeekData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let kcalValue = quantity.doubleValue(for: .kilocalorie())
                        updatedModel.kcalData.append(kcalValue)
                    } else {
                        updatedModel.kcalData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.kcalData))
                    print("kcalData", updatedModel.kcalData)
                }
            }
            HKHealthStore().execute(query)
        }

    func fetchKcalMonthData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let kcalValue = quantity.doubleValue(for: .kilocalorie())
                        updatedModel.kcalData.append(kcalValue)
                    } else {
                        updatedModel.kcalData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.kcalData))
                    print("kcalData", updatedModel.kcalData)
                }
            }
            HKHealthStore().execute(query)
        }

    func fetchKcalYearData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let kcalValue = quantity.doubleValue(for: .kilocalorie())
                        updatedModel.kcalData.append(kcalValue)
                    } else {
                        updatedModel.kcalData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.kcalData))
                    print("kcalData", updatedModel.kcalData)
                }
            }
            HKHealthStore().execute(query)
        }

    func fetchDistanceWeekData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let distanceValue = quantity.doubleValue(for: .meter())
                        updatedModel.distanceData.append(distanceValue)
                    } else {
                        updatedModel.distanceData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.distanceData))
                    print("distanceData", updatedModel.distanceData)
                }
            }
            HKHealthStore().execute(query)
        }

    func fetchDistanceMonthData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .day, value: -30, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let distanceValue = quantity.doubleValue(for: .meter())
                        updatedModel.distanceData.append(distanceValue)
                    } else {
                        updatedModel.distanceData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.distanceData))
                    print("distanceData", updatedModel.distanceData)
                }
            }
            HKHealthStore().execute(query)
        }

    func fetchDistanceYearData(completion: @escaping (Result<[Double], Error>) -> Void) {
            var updatedModel = self

            let oneWeekAgo = Calendar.current.date(byAdding: .month, value: -12, to: Date())!
            let startDate = Calendar.current.startOfDay(for: oneWeekAgo)
            let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: [])

            let query = HKStatisticsCollectionQuery(quantityType: HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)!,
                                                    quantitySamplePredicate: predicate,
                                                    options: .cumulativeSum,
                                                    anchorDate: startDate,
                                                    intervalComponents: DateComponents(day: 1))

            query.initialResultsHandler = { _, results, error in
                guard let statsCollection = results else {
                    if let error = error {
                        completion(.failure(error))
                    }
                    return
                }

                statsCollection.enumerateStatistics(from: startDate, to: Date()) { statistics, _ in
                    if let quantity = statistics.sumQuantity() {
                        let distanceValue = quantity.doubleValue(for: .meter())
                        updatedModel.distanceData.append(distanceValue)
                    } else {
                        updatedModel.distanceData.append(0.0)
                    }
                }

                DispatchQueue.main.async {
                    completion(.success(updatedModel.distanceData))
                    print("distanceData", updatedModel.distanceData)
                }
            }
            HKHealthStore().execute(query)
        }
}
