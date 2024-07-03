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
    @State var bCoin = 0.0
    @State var Battery = 0.0
    @State var ybCoin = 0.0
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: userFaceUrl)) { image in
                    image
                        .resizable() // 允许图片可调整大小
                        .scaledToFit() // 图片将等比缩放以适应框架
                        .frame(width: 200, height: 200) // 设置视图框架的大小
                } placeholder: {
                    ProgressView() // 在加载期间显示进度视图
                }
                .frame(width: 200, height: 200) // 可以重复设置，确保占位符和图片使用相同的尺寸
                .background(Color.gray) // 背景色，以便更易看到尺寸
                Text(userName)
                    .font(.largeTitle)
                    .padding()
                Label(String(bCoin), systemImage: "bitcoinsign.circle").font(.title2)
                Label(String(ybCoin), systemImage: "dollarsign.circle").font(.title2)
                Label(String(Battery), systemImage: "battery.100").font(.title2)

            }.onAppear {
                // TODO: 加载个人信息、头像
                UserService().getUserInfo { result in
                    let userData = result.data
                    if userData.isLogin {
                        userFaceUrl = userData.face!
                        userName = userData.uname!
                        bCoin = userData.getBcoin()
                        ybCoin = userData.getBcoin()
                        
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
