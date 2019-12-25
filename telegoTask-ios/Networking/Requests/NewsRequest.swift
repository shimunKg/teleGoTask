//
//  NewsRequest.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation

struct NewsRequest: ApiRequest {
    var baseUrl = BaseURL.news
    var path = APIPath.getNews
    var method = APIMethod.get
    var body = [String : Any]()
    var urlParams = [String: Any]()
    var requiredAuth = false
}
