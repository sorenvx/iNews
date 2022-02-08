//
//  Article.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import Foundation

struct Article: Codable {
    var title: String
    var photoUrl: String?
    var articleDescription: String?
    var publishedAt: Date
 

    enum CodingKeys: String, CodingKey {
        case articleDescription = "description"
        case title
        case publishedAt
        case photoUrl = "urlToImage"
    }
}

