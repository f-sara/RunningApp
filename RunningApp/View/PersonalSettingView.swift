//
//  PersonalSettingView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct PersonalSettingView: View {
    private let viewModel = PersonalSettingViewModel()

    @State var selectedMode = 0
    @State var selectedSteps = 0
    @State private var height = "160"

    @FocusState var focus:Bool

    var gesture: some Gesture {
        DragGesture()
            .onChanged{ value in
                if value.translation.height != 0 {
                    self.focus = false
                }
            }
    }

    var body: some View {

        Form {

            Section {
                Picker(selection: $selectedMode,
                       label: Text("アプリモード")) {
                    ForEach(0..<2) {
                        Text(self.viewModel.appMode[$0])
                    }
                    .onChange(of: selectedMode) {
                        viewModel.saveAppMode(viewModel.appMode[selectedMode])
                    }
                }
            } header: {
                Text("アプリの設定")
            }


            Section {
                HStack {
                    Text("身長")
                    Spacer()
                    TextField("身長を入力", text: $height)
                        .focused(self.$focus)
                        .foregroundColor(.gray)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                        .onChange(of: height) {
                            viewModel.saveUserHeight(viewModel.userHeight)
                        }
                    Text("cm")
                        .foregroundColor(.gray)
                }
                Picker(selection: $selectedSteps, label: Text("目標歩数")) {
                    ForEach(viewModel.steps.indices, id: \.self) { index in
                        Text("\(self.viewModel.steps[index])")
                    }
                }
                .onChange(of: selectedSteps) {
                    guard viewModel.steps.indices.contains(selectedSteps) else { return }
                    viewModel.saveStepGoal(viewModel.steps[selectedSteps])
                }
            } header: {
                Text("あなたのデータ")
            }
        }
        .gesture(self.gesture)
        .scrollContentBackground(.hidden)
        .background(Color("testcolor"))
        .onAppear {
            if let storedAppMode = UserDefaults.standard.string(forKey: "appMode"),
               let index = viewModel.appMode.firstIndex(of: storedAppMode) {
                selectedMode = index
            }
            if let storedHeight = UserDefaults.standard.string(forKey: "userHeight") {
                height = storedHeight
            }
            let storedStepGoal = UserDefaults.standard.integer(forKey: "stepGoal")
            selectedSteps = viewModel.steps.firstIndex(of: storedStepGoal) ?? 0
        }

    }
}

struct PersonalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettingView()
    }
}
