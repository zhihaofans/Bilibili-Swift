//
//  SettingView.swift
//  bilibili
//
//  Created by zzh on 2024/6/29.
//

import SwiftUI

struct SettingView: View {
    @Binding var showPageId: String
    private let settingIdList = ["bili_jct", "DedeUserID__ckMd5", "SESSDATA", "DedeUserID", "sid"]
    var body: some View {
        VStack {
            Text("登录数据")
            List(settingIdList, id: \.self) { it in
                Text("\(it): \(String(LoginService().getCookieKey(key: it) ?? ""))")
            }
        }
    }
}
