//
//  APIManager.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation

protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}

class ApiManager {

    static let shared = ApiManager()

    // MARK: - Sending API Request

    func sendRequest(_ apiRequest: ApiRequest, completion: @escaping (Result<[String: AnyObject]>) -> Void) {
        guard let request = apiRequest.request() else { return }
        
        /* Start a new Task */
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.error(error!.localizedDescription))
                return
            }
            
            guard let data = data else {
                completion(.error(error?.localizedDescription ?? "There are no data to show"))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.error("Invalid HTTP response"))
                return
            }
            
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [String: AnyObject] {
                    
                    DispatchQueue.main.async {
                        if httpResponse.statusCode > 299 {
                            completion(.errorWithDictionary(json))
                            return
                        }
                        completion(.success(json))
                    }
                }
                
                if let json = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers]) as? [AnyObject] {
                    
                    DispatchQueue.main.async {
                        if httpResponse.statusCode > 299 {
                            completion(.errorWithDictionary(["responseData": json as AnyObject]))
                        }
                        completion(.success(["responseData": json as AnyObject]))
                    }
                }
                
            } catch let error {
                DispatchQueue.main.async {
                    completion(.error(error.localizedDescription))
                }
            }
            
        }.resume()
    }
    
}



enum Result<T> {
    case success(T)
    case error(String)
    case errorWithDictionary([String: AnyObject])
}



enum APIMethod: String {
    case
    post = "POST",
    delete = "DELETE",
    get = "GET",
    put = "PUT"
}


