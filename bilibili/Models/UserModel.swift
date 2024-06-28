//
//  UserModel.swift
//  bilibili
//
//  Created by zzh on 2024/6/28.
//

import Foundation

struct UserInfoResult: Codable {
    let code: Int
    let message: String
    let data: UserInfoData?
}
struct UserInfoData: Codable {
    let isLogin: Bool
    let face: String
    let mid: Int
    let uname: String
    let money: Int //拥有硬币数
}