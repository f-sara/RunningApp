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

        healthDataModel.requestHealthAuthorization { success in
            if success {
                DispatchGroup().enter()
                self.healthDataModel.fetchStepsWeekData { result in
                    switch result {
                    case .success(let step):
                        self.todayStepData = String(step.last ?? 10)
                    case .failure(let error):
                        print(error)
                    }
                }

                DispatchGroup().enter()
                self.healthDataModel.fetchKcalWeekData { result in
                    switch result {
                    case .success(let kcal):
                        self.todayKcalData = String(kcal.last ?? 10)
                        print("todaykcal", self.todayKcalData)
                    case .failure(let error):
                        print(error)
                    }
                }

                DispatchGroup().enter()
                self.healthDataModel.fetchDistanceWeekData { result in
                    switch result {
                    case .success(let distance):
                        self.todayDistanceData = String(distance.last ?? 10)
                    case .failure(let error):
                        print(error)
                    }
                }

                DispatchGroup().notify(queue: .main) {
                    print("終わり", self.todayStepData, self.todayKcalData, self.todayDistanceData)
                }
            } else {
                print("アクセスが許可されていません")

            }

        }

    }

}
