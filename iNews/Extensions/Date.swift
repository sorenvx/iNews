//
//  Date.swift
//  iNews
//
//  Created by Toni De Gea on 8/2/22.
//

import Foundation

extension Date {
    
    var dateToSting: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.string(from: self)
    }
    
}
