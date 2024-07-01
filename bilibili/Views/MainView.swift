//
//  MainView.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//

import SwiftUI

struct MainView: View {
    @Binding var showPageId: String
    @State var showingAlert = false
    @State var alertText = ""
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            CheckinService().mangaCheckin { result in
                alertText = result.msg
                showingAlert = true
            } fail: { error in
                showingAlert = true
                alertText = error
            }

        }) {
            Text("漫画签到").font(.title)
        }
        .alert("结果", isPresented: $showingAlert) {
            Button("OK", action: {})
        } message: {
            Text(alertText)
        }
        Button(action: {
            CheckinService().liveCheckin { result in
                alertText = result.message
                showingAlert = true
            } fail: { error in
                showingAlert = true
                alertText = error
            }

        }) {
            Text("直播签到").font(.title)
        }
        Button(action: {}) {
            Text("稍后再看").font(.title)
        }
        Button(action: {}) {
            Text("历史记录").font(.title)
        }
    }
}
