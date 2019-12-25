//
//  String.swift
//  telegoTask-ios
//
//  Created by Shimun on 12/24/19.
//  Copyright © 2019 Shimun. All rights reserved.
//

import Foundation

extension String {
    
    func toFormat(_ format: String) -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss-05:00"
        formatter.timeZone = TimeZone.current
        if let date = formatter.date(from: self) {
            formatter.dateFormat = format
            return formatter.string(from: date)
        }
        
        return nil
    }
    
}
