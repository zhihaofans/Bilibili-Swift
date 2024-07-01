//
//  LoginView.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//

import SwiftUI
import SwiftUtils

struct LoginView: View {
    @Binding var showPageId: String
    // Login data
    @State private var showingAlert = false
    @State private var alertText: String = "未知错误"
    @State private var qrCodeImage: NSImage? = nil
    @State private var qrcodeKey: String = ""
    @State private var qrcodeText: String = "未登录"
    private let context = CIContext()
    private let filter = CIFilter.qrCodeGenerator()
    private let loginService = LoginService()
    var body: some View {
        Text("打开哔哩哔哩扫描二维码登录")
            .font(.largeTitle)
            .padding()

        /*
         // 使用 AsyncImage 加载在线图片
         AsyncImage(url: URL(string:imageUrl)) { image in
         image
         .resizable()
         .aspectRatio(contentMode: .fit)
         } placeholder: {
         Text("loading...")
         ProgressView() // 加载中的占位图
         }
         .frame(width: 300, height: 300)
         .clipShape(RoundedRectangle(cornerRadius: 15))*/
        if let qrCodeImage = qrCodeImage {
            Image(nsImage: qrCodeImage)
                .resizable()
                .interpolation(.none)
                .scaledToFit()
                .frame(width: 200, height: 200)
        } else {
            Text(qrcodeText)
        }
        Button(action: {
            self.loginService.checkWebLoginQrcode(qrcodeKey: self.qrcodeKey) { checkResult in
                if checkResult.code == 0 {
                    let setSu = KeychainUtil().saveString(forKey: "bilibili.login.refresh_token", value: checkResult.refresh_token)
                    alertText = "保存登录数据" + setSu.string(trueStr: "成功", falseStr: "失败")
                    showingAlert = true
                } else {
                    alertText = checkResult.message
                    showingAlert = true
                }

            } fail: { error in
                alertText = error
                showingAlert = true
            }

        }) {
            Text("登录").font(.title)
        }
        .alert("Error", isPresented: $showingAlert) {
            Button("OK", action: {})
        } message: {
            Text(alertText)
        }
        .onAppear {
            let bili_jct = LoginService().getCookieKey(key: "bili_jct")
            let SESSDATA = LoginService().getCookieKey(key: "SESSDATA")
            let DedeUserID = LoginService().getCookieKey(key: "DedeUserID")
            let DedeUserID__ckMd5 = LoginService().getCookieKey(key: "DedeUserID__ckMd5")
            let sid = LoginService().getCookieKey(key: "sid")
            print("\(String(describing: bili_jct))\n\(String(describing: SESSDATA))\n\(String(describing: DedeUserID))\n\(String(describing: DedeUserID__ckMd5))\n\(String(describing: sid))")
            if DedeUserID != nil {
                qrcodeText = "已登录"
                showPageId = "main"
            } else {
                self.loginService.getWebLoginQrcode { loginData in
                    if !loginData.qrcode_key.isEmpty {
                        qrcodeKey = loginData.qrcode_key
                        // let qrcodeUrl = "https://passport.bilibili.com/h5-app/passport/login/scan?navhide=1&from=&qrcode_key=" + qrcodeKey
                        self.qrCodeImage = QrcodeUtil().generateQRCode(from: loginData.url)
                    } else {
                        alertText = "空白二维码"
                        showingAlert = true
                    }
                } fail: { errorMsg in

                    showingAlert = true
                    alertText = errorMsg
                }
                // self.getQrcodeData()
            }
        }
        .padding()
    }
}

/*
 #Preview {
     LoginView()
 }
 */
