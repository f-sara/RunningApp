//
//  ChartDataView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/22.
//

import SwiftUI

struct ChartDataView: View {

    enum WhatData {
        case step
        case kcal
        case distance

        var dataText: String {
            switch self {
            case .step:
                return "歩"
            case .kcal:
                return "kcal"
            case .distance:
                return "m"
            }
        }
    }

    var whatData: WhatData

    var body: some View {

//        ZStack {
//            Color("white")
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: 350, height: 100)
                    HStack {
                        Text("合計")
                            .font(.system(size: 25))
                            .padding(.bottom, 40)
                            .padding(.trailing, 100)
                        Text("0000")
                            .font(.system(size: 45))
                        Text(whatData.dataText)
                            .font(.system(size: 20))
                            .padding(.top, 20)


                    }
                }

//            }
        }
    }
}

struct ChartDataView_Previews: PreviewProvider {
    static var previews: some View {
        ChartDataView(whatData: .step)
            .previewLayout(.sizeThatFits)
    }
}
