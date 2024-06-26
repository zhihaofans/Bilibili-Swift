//
//  ContentView.swift
//  bilibili
//
//  Created by zzh on 2024/6/13.
//

import SwiftUI

struct ContentView: View {
    private let pageTitleList = ["main": "Bilibili", "login": "登录", "user": "个人中心"]
    @State private var showPageId = "login"
    @State private var showPageTitle = "Bilibili"
    @State private var isLogin = false
    var body: some View {
        VStack {
            switch showPageId.lowercased() {
            case "main":
                MainView(showPageId: $showPageId)
            case "login":
                LoginView(showPageId: $showPageId)
            default:
                Text("错误导航")
                    .font(.largeTitle)
                    .padding()
                Button(action: {
                    showPageId = "main"
                }) {
                    Text("返回主页").font(.title)
                }
            }
        }.toolbar {
            // 增加数据
            Button("Home", systemImage: "house", action: {
                showPageId = "main"
            })
            Button("User", systemImage: "person", action: {
                showPageId = "login"
            })
        }
        .onChange(of: showPageId) {
            // 当 a 改变时，更新 b
            showPageTitle = getPageTitle()
        }
        .onAppear {
            // self.getQrcodeData()
            showPageTitle = getPageTitle()
            if LoginService().getUid()! = nil {
                isLogin = true
                showPageId = "main"
            }
        }.navigationTitle(showPageTitle)
        .padding()
    }

    private func getPageTitle() -> String {
        return pageTitleList[showPageId] ?? "哔哩哔哩"
    }
}

#Preview {
    ContentView()
}
