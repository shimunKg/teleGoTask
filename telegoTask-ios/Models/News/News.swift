//
//  News.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation
import CoreData

enum NewsKey {
    case
    title,
    description,
    slugName,
    publishedDate,
    thumbnail,
    isBookmarked
    
    var text: String! {
        switch self {
        case .title:
            return "title"
        case .description:
            return "descriptionText"
        case .slugName:
            return "slugName"
        case .publishedDate:
            return "publishedDate"
        case .thumbnail:
            return "thumbnail"
        case .isBookmarked:
            return "isBookmarked"
        }
    }
}

struct News: Decodable {
    let title: String?
    let description: String?
    let slugName: String?
    let publishedDate: String?
    let thumbnail: String?
    var isBookmarked: Bool? = false
}

extension News {
    
    enum CodingKeys: String, CodingKey {
        case title
        case description = "abstract"
        case slugName = "slug_name"
        case publishedDate = "published_date"
        case thumbnail = "thumbnail_standard"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        slugName = try container.decodeIfPresent(String.self, forKey: .slugName)
        publishedDate = try container.decodeIfPresent(String.self, forKey: .publishedDate)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
    }
}
