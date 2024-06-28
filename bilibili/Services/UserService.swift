//
//  UserService.swift
//  bilibili
//
//  Created by zzh on 2024/6/27.
//
import Alamofire
import Foundation
import SwiftUtils

class UserService {
    func getUserInfo(callback: @escaping (UserInfoResult)->Void, fail: @escaping (String)->Void) {
        let headers: HTTPHeaders = [
            "Cookie": LoginService().getCookiesString(),
            "Accept": "application/json;charset=UTF-8",
        ]
        AF.request("https://api.bilibili.com/x/web-interface/nav", headers: headers).responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    let result = try JSONDecoder().decode(UserInfoResult.self, from: value.data(using: .utf8)!)
                    debugPrint(result.code)
                    if result.code == 0 {
                        callback(result)
                    } else {
                        fail(result.message)
                    }
                case let .failure(error):
                    print(error)
                    fail(error.localizedDescription)
                }
            } catch {
                print("http.error")
                fail("网络请求错误:\(error.localizedDescription)")
            }
        }
    }
}
