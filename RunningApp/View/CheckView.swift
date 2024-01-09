//
//  CheckView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI

struct CheckView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {

        NavigationStack {
            VStack(spacing: 0) {
                Image("2")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 240)
                    .padding(.bottom, 50)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("white"))
                        .frame(width: 320, height: 200)
                    VStack(spacing: 0) {
                        Text("ルートの記録を始めますか？")
                            .foregroundColor(Color("darkblue"))
                            .font(.system(size: 20.5))
                            .padding(.top, 8)
                            .padding(.bottom, 35)
                        NavigationLink {
                            MapLogView()
                        } label: {
                            NormalButtonView(buttonText: "開始")
                        }
                        .padding(.bottom, 21)
                        Button {
                            dismiss()
                        } label: {
                            Text("キャンセル")
                        }
                        .padding(.bottom, 8)
                    }

                }

            }
            .navigationBarBackButtonHidden(true)
        }
    }

    struct CheckView_Previews: PreviewProvider {
        static var previews: some View {
            CheckView()
                .previewLayout(.sizeThatFits)
        }
    }
}
