//
//  PersonalSettingViewModel.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2024/01/22.
//
import Foundation

final class PersonalSettingViewModel {
    let appMode = ["ランニングモード", "ウォーキングモード"]
    let steps = [5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000, 15000]
    var userHeight = "160"

    func saveAppMode(_ mode: String) {
        UserDefaults.standard.set(mode, forKey: "appMode")
    }

    func saveUserHeight(_ height: String) {
        UserDefaults.standard.set(height, forKey: "userHeight")
    }

    func saveStepGoal(_ goal: Int) {
        UserDefaults.standard.set(goal, forKey: "stepGoal")
    }
}

