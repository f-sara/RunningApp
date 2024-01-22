//
//  PersonalSettingView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct PersonalSettingView: View {
    private let mode = ["ランニングモード", "ウォーキングモード"]
    @State var selected = 0
    @State var selected2 = 0
    @State private var height = "160"
    let steps = [5000, 5500, 6000, 6500, 7000, 7500, 8000, 8500, 9000, 9500, 10000, 15000]

    var body: some View {

        Form {
            Section {
                Picker(selection: $selected,
                       label: Text("アプリモード")) {
                    ForEach(0..<2) {
                        Text(self.mode[$0])
                    }
                }
            } header: {
                Text("アプリの設定")
            }

            Section {
                HStack {
                    Text("身長")
                    Spacer()
                    TextField("cm", text: $height)
                        .foregroundColor(.gray)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }
                Picker(selection: $selected2, label: Text("目標歩数")) {
                    ForEach(0..<12) {
                        Text("\(self.steps[$0])")
                    }

                }
            } header: {
                Text("あなたのデータ")
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color("testcolor"))
        .onTapGesture {
            UIApplication.shared.closeKeyboard()
        }
    }
}

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct PersonalSettingView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettingView()
    }
}
