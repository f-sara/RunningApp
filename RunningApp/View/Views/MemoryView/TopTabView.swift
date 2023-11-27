//
//  TopTabView.swift
//  RunningApp
//
//  Created by 藤井紗良 on 2023/11/26.
//

import SwiftUI

struct TopTabView: View {
    let list: [String]
    @Binding var selectedTab: Int

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0 ..< list.count, id: \.self) { row in
                Button(action: {
                    withAnimation {
                        selectedTab = row
                    }
                }, label: {
                    VStack(spacing: 0) {
                        HStack {
                            Text(list[row])
                                .foregroundColor(Color.black)
                                .font(.system(size: 14))
                        }
                        .frame(
                            width: (UIScreen.main.bounds.width / CGFloat(list.count)),
                            height: 48 - 3
                        )
                        Rectangle()
                            .fill(selectedTab == row ? Color.green : Color.clear)
                            .frame(height: 3)
                    }
                    .fixedSize()
                })
            }
        }
        .frame(height: 38)
        .background(Color.white)
        .compositingGroup()
        .shadow(color: .primary.opacity(0.03), radius: 2, x: 4, y: 4)
    }
}
