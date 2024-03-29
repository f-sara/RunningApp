//
//  StartButtonView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct StartButtonView: View {
//    var body: some View {
//        VStack(spacing: 4) {
//            Image(systemName: "location.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 42, height: 42)
//                .foregroundColor(Color.green)
//
//            Text("ルートを記録")
//                .font(.system(size: 11))
//                .foregroundColor(Color.green)
//                .bold()
//                .padding(.bottom, 8)
//        }
//        .frame(width: 90, height: 90)
//        .background(Color.white)
//        .cornerRadius(90)
//        .overlay(
//            RoundedRectangle(cornerRadius: 90)
//                .stroke(Color.green, lineWidth: 1.5)
//            
//        )
//
//    }
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: "chart.bar.xaxis")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 35)
                .foregroundColor(Color.green)

            Text("過去の記録を確認する")
                .font(.system(size: 20))
                .foregroundColor(Color.green)
            
                .bold()
        }
        .frame(width: 250, height: 60)
        .background(Color.white)
        .cornerRadius(5)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.green, lineWidth: 1.5)

        )

    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .previewLayout(.sizeThatFits)
    }
}
