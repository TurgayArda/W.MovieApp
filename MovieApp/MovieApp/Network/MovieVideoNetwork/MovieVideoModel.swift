//
//  MovieVideoModel.swift
//  MovieApp
//
//  Created by ArdaSisli on 6.08.2022.
//

import Foundation

// MARK: - MovieCastResult

struct MovieVideoResult: Codable {
    let id: Int?
    let results: [Video]?
}

// MARK: - Result

struct Video: Codable {
    let name, key: String?
    let site: Site?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

enum Site: String, Codable {
    case youTube = "YouTube"
}

