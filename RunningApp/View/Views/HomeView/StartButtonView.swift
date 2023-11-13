//
//  StartButtonView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct StartButtonView: View {
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 2.5) {
                Image(systemName: "figure.walk.motion")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
                    .foregroundColor(Color.blue)

                Text("計測")
                    .font(.system(size: 20))
                    .foregroundColor(Color.blue)
                    .bold()
            }
        }
        .frame(width: 90, height: 85)
        .background(Color.white)
        .cornerRadius(35)
        .overlay(
            RoundedRectangle(cornerRadius: 35)
                .stroke(Color.blue, lineWidth: 2.5)
        )
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .previewLayout(.sizeThatFits)
    }
}
