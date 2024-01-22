//
//  PersonalSettingView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct PersonalSettingView: View {
    @ObservedObject var viewModel = PersonalSettingViewModel()
    let mode = ["ランニングモード", "ウォーキングモード"]
    @State var selected = 0
    @State var selected2 = 0
    @State private var height = "160"
    let steps = [5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000, 15000]

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
                Picker(selection: $selected,
                       label: Text("アプリモード")) {
                    ForEach(0..<2) {
                        Text(self.mode[$0])
                    }
                    .onChange(of: selected) {
                        UserDefaults.standard.set(mode[selected], forKey: "appMode")
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
                        UserDefaults.standard.set(height, forKey: "userHeight")
                    }
                Text("cm")
                    .foregroundColor(.gray)
            }
            Picker(selection: $selected2, label: Text("目標歩数")) {
                ForEach(steps.indices, id: \.self) { index in
                    Text("\(self.steps[index])")
                }
            }
            .onChange(of: selected2) {
                guard steps.indices.contains(selected2) else { return }
                    UserDefaults.standard.set(steps[selected2], forKey: "stepGoal")
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
               let index = mode.firstIndex(of: storedAppMode) {
                selected = index
            }
            if let storedHeight = UserDefaults.standard.string(forKey: "userHeight") {
                height = storedHeight
            }
            let storedStepGoal = UserDefaults.standard.integer(forKey: "stepGoal")
            guard let selected2 = steps.firstIndex(of: storedStepGoal) else {return}
        }

}
}

struct PersonalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettingView()
    }
}
