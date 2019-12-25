//
//  NewsRepository.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/23/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation

protocol NewsRepositoryDelegate {
    func loadFromAPI(completion: @escaping ([News], String?) -> Void)
}

struct NewsRepository {
    
    let networkService: ApiManager!
    
    init(networkService: ApiManager) {
        self.networkService = networkService
    }
    
    func loadFromAPI(completion: @escaping ([News], String?) -> Void) {
        networkService.sendRequest(NewsRequest()) { (result) in
            switch result {
            case .success(let data):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data["results"]!, options: .prettyPrinted)
                    let news = try JSONDecoder().decode([News].self, from: jsonData)
                    completion(news, nil)
                } catch {
                    completion([News](), error.localizedDescription)
                }
            case .error(let error):
                completion([News](), error)
            case .errorWithDictionary(let errorDictionary):
                print(errorDictionary)
                completion([News](), "error")
            }
        }
    }
    
}
