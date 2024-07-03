//
//  HistoryView.swift
//  bilibili
//
//  Created by zzh on 2024/7/2.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(
                    1...10,
                    id: \.self
                ) {
                    Text("Item \($0)")
                    Text("Item \($0)")
                }
            }.onAppear {
                // TODO: 加载历史数据
            }
        }
    }
}

#Preview {
    HistoryView()
}
