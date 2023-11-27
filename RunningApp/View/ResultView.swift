//
//  ResultView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/25.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button {
                dismiss()
                dismiss()
                dismiss()
            } label: {
                NormalButtonView(buttonText: "終了")
            }
        }
        .interactiveDismissDisabled()
        .navigationBarBackButtonHidden(true)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
