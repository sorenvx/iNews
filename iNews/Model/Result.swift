//
//  Result.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import Foundation

struct Result: Decodable {
        var status: String
        var totalResults: Int
        var articles: [Article]
}
