//
//  APIRequests.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation
//import MobileCoreServices

protocol ApiRequest {
    var baseUrl: BaseURL { get }
    var path: APIPath { get }
    var method: APIMethod { get }
    var body: [String: Any] { get set }
    var urlParams: [String: Any] { get set }
    var requiredAuth: Bool { get }
    var defaultHeader: Bool { get }
}

extension ApiRequest {

    var defaultHeader: Bool {
        return true
    }
    
    func defaultHeader(_ request: URLRequest) -> URLRequest {
        
        if !self.defaultHeader {
            return request
        }

        var request = request
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

        return request
    }

    func request() -> URLRequest? {

        guard let URL = URL(string: self.baseUrl.rawValue + self.path.path) else {
            return nil
        }

        var request = URLRequest(url: URL)
        request.httpMethod = self.method.rawValue
        
        // Headers
        request = defaultHeader(request)

        // Setup body
        if self.body.count > 0 {
            request.httpBody = try! JSONSerialization.data(withJSONObject: self.body, options: [])
        }
        
        return request
    }
}


