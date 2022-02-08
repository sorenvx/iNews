//
//  ArticlePresenter.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import Foundation

class ArticlePresenter {
    private weak var articleViewDelegate: ArticleViewDelegate?
    
    func setViewDelegate(articleViewDelegate: ArticleViewDelegate) {
        self.articleViewDelegate = articleViewDelegate
    }
    func getArticles() {
        NewsCommunications.shared.fecthAllNews { success in
            if success {
                print("YAY")
                guard let news = NewsCommunications.shared.allNews else {
                    self.articleViewDelegate?.showError(error: "No hay noticias que mostrar")
                    return
                }
                self.articleViewDelegate?.showArticles(article: news)
            } else {
                if NewsCommunications.shared.statusCode == 400 {
                    self.articleViewDelegate?.showError(error: "Error al cargar las noticias. Intentelo más tarde")
                }
            }
        }
    }
}

protocol ArticleViewDelegate: AnyObject {
    func showArticles(article: Result)
    func showError(error: String)
}
