//
//  NSManagedObjectContext.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    
    func saveData() {
        do {
            try self.save()
        } catch {
            
        }
    }
}
