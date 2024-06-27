//
//  CheckinService.swift
//  bilibili
//
//  Created by zzh on 2024/6/27.
//
import Alamofire
import Foundation
import SwiftUtils

class CheckinService {
    func mangaCheckin(callback: @escaping (MangaCheckinResult)->Void, fail: @escaping (String)->Void){
        //TODO: http.post
        AF.request("https://manga.bilibili.com/twirp/activity.v1.Activity/ClockIn",method: .post).responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    let result = try JSONDecoder().decode(MangaCheckinResult.self, from: value.data(using: .utf8)!)
                    debugPrint(loginResult.code)
                    if result.code == 0 {
                        callback(result)
                    } else {
                        fail(result.msg)
                    }
                case let .failure(error):
                    print(error)
                    fail(error.localizedDescription)
                }
            } catch {
                print("mangaCheckin.http.error")
                fail("网络请求错误")
            }
        }
    }
    func liveCheckin(callback: @escaping (LiveCheckinResult)->Void, fail: @escaping (String)->Void){
        AF.request("https://api.live.bilibili.com/rc/v1/Sign/doSign").responseString { response in
            do {
                switch response.result {
                case let .success(value):
                    let result = try JSONDecoder().decode(LiveCheckinResult.self, from: value.data(using: .utf8)!)
                    debugPrint(loginResult.code)
                    if result.code == 0 {
                        callback(result)
                    } else {
                        fail(result.msg)
                    }
                case let .failure(error):
                    print(error)
                    fail(error.localizedDescription)
                }
            } catch {
                print("mangaCheckin.http.error")
                fail("网络请求错误")
            }
        }
    }
}