//
//  TodayRecordView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2024/01/11.
//

import SwiftUI

struct TodayRecordView: View {
    var icon: String
    var data: String
    var title: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 20)
                .foregroundColor(Color.black.opacity(0.6))
            Text(data)
                .font(.system(size: 30))
                .bold()
                .frame(height: 40)
            Text(title)
                .font(.system(size: 13))
        }
        .frame(width: 120, height: 110)
    }
}

#Preview {
    TodayRecordView(icon: "figure.walk", data: "10", title: "歩数")
}
