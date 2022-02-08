//
//  ViewController.swift
//  iNews
//
//  Created by Toni De Gea on 7/2/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchBarNews: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let articlesPresenter = ArticlePresenter()
    var barOn = false
    var result: Result?
    var filteredArticles: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        articlesPresenter.setViewDelegate(articleViewDelegate: self)
        fetchArticles()
    }
    
    func fetchArticles() {
        articlesPresenter.getArticles()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBarNews.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let result = result else { return  0 }
        if barOn {
            return filteredArticles.count
        } else {
            return result.articles.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticlesTableViewCell.cellIdentifier, for: indexPath) as? ArticlesTableViewCell else {
            return UITableViewCell()
        }
        guard let result = result?.articles else { return UITableViewCell() }
        var articles = result[indexPath.row]
        var count = result.count
        if barOn {
            articles = filteredArticles[indexPath.row]
            count = filteredArticles.count
        }
        if indexPath.row < count {
            cell.configureCell(title: articles.title, description: articles.articleDescription ?? "", image: articles.photoUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ArticleDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? DetailViewController,
              let indexPath = sender as? IndexPath else {
                  return
              }
        if barOn {
            destination.article = filteredArticles[indexPath.row]
        } else {
            destination.article = result?.articles[indexPath.row]
        }
    }
    
}

extension ViewController: ArticleViewDelegate {
    func showArticles(article: Result) {
        result = article
        tableView.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: error, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let articles = result?.articles else { return }
        if !searchText.isEmpty {
            filteredArticles = articles.filter{ $0.title.lowercased().contains(searchText.lowercased())}
            barOn = true
            tableView.reloadData()
        } else {
            filteredArticles.removeAll()
            barOn = false
            tableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredArticles.removeAll()
        barOn = false
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        searchBar.resignFirstResponder()
    }
}
