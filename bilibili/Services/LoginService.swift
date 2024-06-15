//
//  LoginService.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//
import Alamofire
import Foundation

class LoginService {
    func getWebLoginQrcode(callback: @escaping (LoginQrcodeData)->Void, fail: @escaping (String)->Void) {
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/generate").responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    let loginResult = try JSONDecoder().decode(LoginQrcodeResult.self, from: value.data(using: .utf8)!)
                    debugPrint(loginResult.code)
                    if loginResult.code == 0 {
                        callback(loginResult.data)
                    } else {
                        fail(loginResult.message)
                    }
                case let .failure(error):
                    print(error)
                    fail(error.localizedDescription)
                }
            } catch {
                print("getWebLoginQrcode.http.error")
                fail("网络请求错误")
            }
        }
    }

    func checkWebLoginQrcode(qrcodeKey: String, callback: @escaping (LoginQrcodeCheckData)->Void, fail: @escaping (String)->Void) {
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=" + qrcodeKey).responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    let checkResult = try JSONDecoder().decode(LoginQrcodeCheckResult.self, from: value.data(using: .utf8)!)
                    debugPrint(checkResult.code)
                    if checkResult.code == 0 {
                        callback(checkResult.data)
                    } else {
                        fail(checkResult.message)
                    }

                case let .failure(error):
                    print(error)
                    fail(error.localizedDescription)
                }
            } catch {
                print("getWebLoginQrcode.http.error")
                fail("网络请求错误")
            }
        }
    }
}
