//
//  MemoryView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/13.
//

import SwiftUI
import Charts

struct MemoryView: View {

    var body: some View {
        ScrollView {
            VStack {
                ChartView(typeOfData: .step)
                ChartView(typeOfData: .kcal)
                ChartView(typeOfData: .distance)
            }
        }
    }

    struct MemoryView_Previews: PreviewProvider {
        static var previews: some View {
            MemoryView()
        }
    }
}
