//
//  UserView.swift
//  bilibili
//
//  Created by zzh on 2024/6/28.
//

import SwiftUI

struct UserView: View {
    @Binding var showPageId: String
    @State var userFaceUrl = "https://i0.hdslb.com/bfs/static/jinkela/long/images/vip-login-banner.png"
    @State var userName = "未登录..."
    var body: some View {
        ScrollView {
            VStack {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                AsyncImage(url: URL(string: userFaceUrl))
                Text(userName)
                    .font(.largeTitle)
                    .padding()

            }.onAppear {
                // TODO: 加载个人信息、头像
                UserService().getUserInfo { result in
                    let userData = result.data
                    if userData.isLogin {
                        userFaceUrl = userData.face!
                        userName = userData.uname!
                    } else {
                        userName = "加载失败:未登录"
                    }
                } fail: { errStr in
                    userName = "加载失败:\(errStr)"
                }
            }
        }
    }
}
