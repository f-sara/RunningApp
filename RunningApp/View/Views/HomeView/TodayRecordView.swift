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
                .foregroundColor(Color.white.opacity(0.6))
            Text(data)
                .font(.system(size: 28))
                .bold()
                .frame(height: 40)
                .foregroundColor(.white)
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(Color.white.opacity(0.6))
        }
        .frame(width: 115, height: 110)
    }
}

#Preview {
    TodayRecordView(icon: "figure.walk", data: "10", title: "歩数")
}
