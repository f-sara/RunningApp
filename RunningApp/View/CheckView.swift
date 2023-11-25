//
//  CheckView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct CheckView: View {
    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink {
                    MapLogView()
                } label: {
                    Text("計測開始")
                }
            }
        }
        .interactiveDismissDisabled()
        .navigationBarBackButtonHidden(true)

    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView()
    }
}
