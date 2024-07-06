//
//  HistoryView.swift
//  bilibili
//
//  Created by zzh on 2024/7/2.
//

import SwiftUI

struct HistoryView: View {
    @State var isError=false
    @State var errorStr=""
    @State var historyList: [HistoryItem]
    var body: some View {
        ScrollView {
            VStack {
                if isError {
                    Text(errorStr).font(.largeTitle)
                } else {
                    ForEach(
                        historyList,
                        id: \.self
                    ) {
                        // HistoryItemView(coverUrl: "https://http.cat/images/200.jpg", title: "title \($0)", author: "作者 \($0)")
                        Text("\($0)")
                    }
                }
            }.onAppear {
                // TODO: 加载历史数据
                HistoryService().getHistory { result in
                    if result.data.list.isEmpty {
                        isError=true
                        errorStr="空白结果列表"
                    } else {
                        historyList=result.data.list
                        isError=false
                    }
                } fail: { err in
                    isError=true
                    errorStr=err
                }
            }
        }
    }
}

struct HistoryItemView: View {
    var itemData: HistoryList
    var body: some View {
        VStack {
            HSplitView {
                AsyncImage(url: URL(string: itemData.getCover())) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 84)
                VStack {
                    Text(itemData.title)
                    Text(itemData.author_name)
                }
                .frame(width: 150)
            }
        }
        .frame(height: 100) // 将 VStack 的固定高度设置为100
        .contentShape(Rectangle()) // 加这行才实现可点击
        .onTapGesture {
            // TODO: onClick
        }
    }
}
