//
//  ArticlePresenter.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import Foundation

class ArticlePresenter {
    private weak var articleViewDelegate: ArticleViewDelegate?
    private let RESULTS_CACHE = "cacheResults"
    
    func setViewDelegate(articleViewDelegate: ArticleViewDelegate) {
        self.articleViewDelegate = articleViewDelegate
    }
    func getArticles() {
        NewsCommunications.shared.fecthAllNews { success in
            if success {
                guard let news = NewsCommunications.shared.allNews else {
                    self.articleViewDelegate?.showError(error: "No hay noticias que mostrar")
                    return
                }
                self.articleViewDelegate?.showArticles(article: news)
            } else {
                self.articleViewDelegate?.showError(error: "Error al cargar las noticias. Inténtelo más tarde. \n Las noticias que pueda estar viendo no serán las más actuales.")
                // Si la cache tiene datos lo mostrará cuando no tengamos internet.
                if let cache = self.getData() {
                    self.articleViewDelegate?.showArticles(article: cache)
                }
            }
        }
    }
    
    func saveData(news: Result) {
        let encodedData = try? PropertyListEncoder().encode(news)
        if let encodedData = encodedData {
            UserDefaults.standard.set(encodedData, forKey: self.RESULTS_CACHE)
        }
    }
    
    func getData() -> Result? {
        var cache: Result?
        if let decoded  = UserDefaults.standard.object(forKey: self.RESULTS_CACHE) as? Data {
            let decodedTeams = try? PropertyListDecoder().decode(Result.self, from: decoded)
              if let cacheDecoded = decodedTeams {
                  cache = cacheDecoded
              }
        }
        return cache
    }
}

protocol ArticleViewDelegate: AnyObject {
    // Protocolo para poder pasar datos del presenter al ViewController
    func showArticles(article: Result)
    func showError(error: String)
}
