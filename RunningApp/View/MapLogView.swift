//
//  MapLogView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/25.
//

import SwiftUI

struct MapLogView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Button {
                dismiss()
                dismiss()
            } label: {
                Text("終了")
            }
        }
        .interactiveDismissDisabled()

    }
}

struct MapLogView_Previews: PreviewProvider {
    static var previews: some View {
        MapLogView()
    }
}
