//
//  HomeHealthViewModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2024/01/09.
//

import Foundation

final class HomeHealthViewModel: ObservableObject {
    @Published var healthDataModel = HealthDataModel()

    var todayStepData: String = ""
    var todayKcalData: String = ""
    var todayDistanceData: String = ""

    func onAppearHomeView() {

        let dispatchGroup = DispatchGroup()

        healthDataModel.requestHealthAuthorization { success in
            if success {
                dispatchGroup.enter()
                self.healthDataModel.fetchStepsWeekData { result in
                    switch result {
                    case .success(let step):
                        self.todayStepData = String(step.last ?? 10)
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                    }
                }

                dispatchGroup.enter()
                self.healthDataModel.fetchKcalWeekData { result in
                    switch result {
                    case .success(let kcal):
                        let kcalData = round(kcal.last ?? 0)
                        self.todayKcalData = String(kcalData)
                        print("todaykcal", self.todayKcalData)
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                    }
                }

                dispatchGroup.enter()
                self.healthDataModel.fetchDistanceWeekData { result in
                    switch result {
                    case .success(let distance):
                        let kmData = floor(distance.last ?? 0 * 10000)/10
                        self.todayDistanceData = String(kmData)
                        dispatchGroup.leave()
                    case .failure(let error):
                        print(error)
                    }
                }

                dispatchGroup.notify(queue: .main) {
                    print("終わり", self.todayStepData, self.todayKcalData, self.todayDistanceData)
                    NotificationCenter.default.post(name: .processDidFinish, object: nil)
                }
            } else {
                print("アクセスが許可されていません")

            }

        }

    }

}

extension Notification.Name {
    static let processDidFinish = Notification.Name("processDidFinish")
}
