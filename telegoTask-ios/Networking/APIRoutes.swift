//
//  APIRoutes.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation

let API_KEY = "JQs0miwlP7dmgZFl4DpMCDl57JMpD3L1"

enum BaseURL: String {
    case news = "https://api.nytimes.com/svc/news/v3/content"
}

enum APIPath {
    
    case getNews
    
    var path: String {
        switch self {
        case .getNews:
            return "/all/all.json?api-key=\(API_KEY)"
        }
    }
}

