//
//  HistoryModel.swift
//  bilibili
//
//  Created by zzh on 2024/7/2.
//

import Foundation

struct HistoryResult: Codable {
    let code: Int
    let msg: String
    let data: HistoryData
}

struct HistoryData: Codable {
    let list: [HistoryList]
}
struct HistoryList: Codable {
    let title: String
    let author_name: String
    let author_face: String
    let author_mid: Int
    let view_at	: Int
}
