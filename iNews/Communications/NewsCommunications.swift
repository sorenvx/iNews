//
//  NewsCommunications.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import Foundation
import Alamofire
import AlamofireImage

typealias CompletionHandler = (_ Success: Bool) -> Void

class NewsCommunications {
    static let shared = NewsCommunications()
    private let BASEURL = "https://newsapi.org/v2/top-headlines?country=us&apiKey="
    private let APIKey = "4198e99ebeba40568600ee3b67c6f77d"
    private let serviceDateFormat = "yyy-MM-dd'T'HH:mm:ssZ"
    var statusCode = 0
    var allNews: Result?
    
    func fecthAllNews(completion: @escaping CompletionHandler) {
        AF.request(BASEURL + APIKey, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            guard let statusCode = response.response?.statusCode else {
                completion(false)
                return
            }
            self.statusCode = statusCode
            if response.error != nil {
                completion(false)
                return
            }
            switch self.statusCode {
            case 200:
                guard let data = response.data else { return }
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = self.serviceDateFormat
                dateFormatter.locale = Locale(identifier: "es_ES")
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                do {
                    self.allNews = try decoder.decode(Result.self, from: data)
                    completion(true)
                } catch {
                    completion(false)
                }
            default:
                completion(false)
            }
            
        }
    }
}
