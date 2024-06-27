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
            case "user":
                UserView(showPageId: $showPageId)
            default:
                Text("计划中...")
                    .font(.largeTitle)
                    .padding()
            }
        }.toolbar {
            // 增加数据
            Button("Home", systemImage: "house", action: {
                showPageId = "main"
            })
            Button("Fav", systemImage: "star", action: {
                showPageId = "main"
            })
            Button("User", systemImage: "person", action: {
                if isLogin {
                    showPageId = "user"
                } else {
                    showPageId = "login"
                }
            })
            Button("Setting", systemImage: "gear", action: {
                showPageId = "setting"
            })
        }
        .onChange(of: showPageId) {
            // 当 a 改变时，更新 b
            showPageTitle = getPageTitle()
        }
        .onAppear {
            // self.getQrcodeData()
            showPageTitle = getPageTitle()
            isLogin = LoginService().isLogin()
            if isLogin {
                showPageId = "main"
            } else {
                showPageId = "login"
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
