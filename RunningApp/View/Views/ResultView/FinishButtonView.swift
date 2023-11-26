//
//  FinishButtonView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/26.
//

import SwiftUI

struct FinishButtonView: View {
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "location.slash")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .foregroundColor(Color.green)

            Text("終了する")
                .font(.system(size: 15))
                .foregroundColor(Color.green)
                .bold()
                .padding(.bottom, 5)
        }
        .frame(width: 90, height: 90)
        .background(Color.white)
        .cornerRadius(90)
        .overlay(
            RoundedRectangle(cornerRadius: 90)
                .stroke(Color.green, lineWidth: 1.5)

        )
    }
}

struct FinishButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FinishButtonView()
    }
}
