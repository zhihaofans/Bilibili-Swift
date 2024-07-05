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
                    1 ... 10,
                    id: \.self
                ) {
                    HistoryItemView(coverUrl:  "https://http.cat/images/200.jpg", title: "title \($0)", author: "作者 \($0)")
                }
            }.onAppear {
                // TODO: 加载历史数据
            }
        }
    }
}

struct HistoryItemView: View {
    var coverUrl: String
    var title: String
    var author: String
    var body: some View {
        VStack {
            HSplitView {
                AsyncImage(url: URL(string: coverUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 84)
                VStack {
                    Text(title)
                    Text(author)
                }
                .frame(width: 150)
            }
        }
        .frame(height: 100) // 将 VStack 的固定高度设置为100
    }
}

#Preview {
    HistoryView()
}
