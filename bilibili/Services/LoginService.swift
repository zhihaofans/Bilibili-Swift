//
//  LoginService.swift
//  bilibili
//
//  Created by zzh on 2024/6/14.
//
import Alamofire
import Foundation

class LoginService {
    func getWebLoginQrcode(callback: @escaping (String)->Void, fail: @escaping (String)->Void) {
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/generate").responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    debugPrint(value)
                    let fakeJsonStr = value
                    let loginResult = try JSONDecoder().decode(LoginQrcodeResult.self, from: fakeJsonStr.data(using: .utf8)!)
                    debugPrint(loginResult.code)
                    if loginResult.code == 0, loginResult.data.qrcode_key.isNotEmpty {
                        callback(loginResult.data.qrcode_key)
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

    func checkWebLoginQrcode(qrcodeKey: String, callback: @escaping (String)->Void, fail: @escaping (String)->Void) {
        AF.request("https://passport.bilibili.com/x/passport-login/web/qrcode/poll?qrcode_key=" + qrcodeKey).responseJSON { response in
            switch response.result {
            case .success:
                debugPrint(response.value as Any)
                if let dict = response.value as? [String: Any] {
                    if let data = dict["data"] as? [String: Any] {
                        if let url = data["url"] as? String {
                            callback(url)
                        } else {
                            fail("返回空白网址")
                        }
                    } else {
                        fail("返回空白数据")
                    }
                } else {
                    fail("返回空白")
                }

            case let .failure(error):
                print(error)
                fail(error.localizedDescription)
            }
        }
    }
}
