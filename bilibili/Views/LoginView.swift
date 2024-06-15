//
//  LoginView.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//

import SwiftUI

struct LoginView: View {
    @Binding var showPageId: String
    // Login data
    @State private var showingAlert = false
    @State private var alertText: String = "未知错误"
    @State private var qrCodeImage: NSImage? = nil
    @State private var qrcodeKey: String = ""
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
        /* if let qrCodeImage = qrCodeImage {
             Image(nsImage: qrCodeImage)
                 .resizable()
                 .interpolation(.none)
                 .scaledToFit()
                 .frame(width: 200, height: 200)
         } else {
             Text("生成中...")
         } */
        Button(action: {
            // self.loginService.checkWebLoginQrcode(qrcodeKey: self.qrcodeKey) { _ in} fail: { _ in}
            
            showingAlert = true
            alertText = "未登录"

        }) {
            Text("登录").font(.title)
        }
        .alert("Error", isPresented: $showingAlert) {
            Button("OK", action: {})
        } message: {
            Text(alertText)
        }
        .onAppear {
            self.loginService.getWebLoginQrcode { qrcode_key in
                if !qrcode_key.isEmpty {
                    qrcodeKey = qrcode_key
                    let qrcodeUrl = "https://passport.bilibili.com/h5-app/passport/login/scan?navhide=1&from=&qrcode_key=" + qrcodeKey
                    self.qrCodeImage = QrcodeUtil().generateQRCode(from: qrcodeUrl)
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
        .padding()
    }
}

/*
 #Preview {
     LoginView()
 }
 */
