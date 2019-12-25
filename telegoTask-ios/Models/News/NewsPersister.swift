//
//  NewsPersister.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import UIKit
import CoreData

protocol NewsPersisterProtocol: class {
    func addToBookmarked(news: News)
    func removeFromBookmarked(news: News)
    func getBookmarkedNews(completion: @escaping ([News]) -> Void)
}

class NewsPersister {
    
    // MARK: - Properties

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Private methods

    private func parseNewsObject(object: NSManagedObject) -> News {
        return News(title: object.value(forKey: NewsKey.title.text) as? String,
                    description: object.value(forKey: NewsKey.description.text) as? String,
                    slugName: object.value(forKey: NewsKey.slugName.text) as? String,
                    publishedDate: object.value(forKey: NewsKey.publishedDate.text) as? String,
                    thumbnail: object.value(forKey: NewsKey.thumbnail.text) as? String,
                    isBookmarked: object.value(forKey: NewsKey.isBookmarked.text) as? Bool)
    }
    
}

// MARK: - NewsPersisterProtocol methods

extension NewsPersister: NewsPersisterProtocol {
    
    func addToBookmarked(news: News) {
        let context = appDelegate.persistentContainer.viewContext
        
        let newsEntity = NSEntityDescription.insertNewObject(forEntityName: "NewsEntity", into: context)
        newsEntity.setValue(news.title, forKey: NewsKey.title.text)
        newsEntity.setValue(news.description, forKey: NewsKey.description.text)
        newsEntity.setValue(news.slugName, forKey: NewsKey.slugName.text)
        newsEntity.setValue(news.publishedDate, forKey: NewsKey.publishedDate.text)
        newsEntity.setValue(news.thumbnail, forKey: NewsKey.thumbnail.text)
        newsEntity.setValue(news.isBookmarked, forKey: NewsKey.isBookmarked.text)

        context.saveData()
        NotificationCenter.default.post(name: Notification.Name("BookmarskUpdated"), object: nil)
    }
    
    func removeFromBookmarked(news: News) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                if let resultsManagedObject = results as? [NSManagedObject] {
                    for object in resultsManagedObject {
                        if object.value(forKey: NewsKey.slugName.text) as? String == news.slugName {
                            context.delete(object)
                            context.saveData()
                            NotificationCenter.default.post(name: Notification.Name("BookmarskUpdated"), object: nil)
                            break
                        }
                    }
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBookmarkedNews(completion: @escaping ([News]) -> Void) {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "NewsEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(request)
            if results.count > 0 {
                if let resultsManagedObject = results as? [NSManagedObject] {
                    var news = [News]()
                    resultsManagedObject.forEach { (object) in
                        news.append(self.parseNewsObject(object: object))
                    }
                    completion(news)
                }
            } else {
                completion([])
            }
        } catch {
            completion([])
        }
    }
    
}
