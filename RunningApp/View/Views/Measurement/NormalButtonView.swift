//
//  NormalButtonView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/27.
//

import SwiftUI

struct NormalButtonView: View {
    var buttonText: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.blue)
                .frame(width: 200,height: 50)
            Text(buttonText)
                .font(.system(size: 20))
                .foregroundColor(.white)
        }
    }
}

struct NormalButtonView_Previews: PreviewProvider {
    static var previews: some View {
        NormalButtonView(buttonText: "計測開始")
    }
}
