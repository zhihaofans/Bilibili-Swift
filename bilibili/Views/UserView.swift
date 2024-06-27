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
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        AsyncImage(url: URL(string: userFaceUrl))
    }
    .onAppear {
        //TODO: 加载个人信息、头像
        
    }
}
