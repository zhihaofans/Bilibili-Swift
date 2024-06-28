//
//  CheckinModel.swift
//  bilibili
//
//  Created by zzh on 2024/6/27.
//

import Foundation

struct MangaCheckinResult: Codable {
    let code: Int
    let msg: String
    enum CodingKeys: String, CodingKey {
        case message = "msg"
        case code
    }
}

struct LiveCheckinResult: Codable {
    let code: Int
    let message: String
}
