//
//  HistoryModel.swift
//  bilibili
//
//  Created by zzh on 2024/7/2.
//

import Foundation

struct HistoryResult: Codable {
    let code: Int
    let message: String
    let data: HistoryData
}

struct HistoryData: Codable {
    let list: [HistoryItem]
}

struct HistoryItem: Codable {
    let title: String
    let author_name: String
    let author_face: String
    let author_mid: Int
    let view_at: Int
    let cover: String?
    let covers: [String]?
    let history: HistoryItemInfo
    func getCover() -> String {
        let cover = self.covers?[0] ?? self.cover ?? "https://http.cat/images/404.jpg"
        return cover.replacingOccurrences(of: "http://", with: "https://")
    }
}

struct HistoryItemInfo: Codable {
    private let business: String
    private let dt: Int
    let oid: Int? // 稿件视频&剧集avid、直播、文章、文集
    let epid: Int?
    let bvid: String?
    func getId() -> String {
        switch self.business {
            case "archive":
                return self.bvid!
            case "pgc":
                return self.epid!.toString
            case "live", "article", "article-list":
                return self.oid!.toString
            default:
                return ""
        }
    }
    func getType() -> String{
        return self.business
    }
}
