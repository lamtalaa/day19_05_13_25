//
//  NewsViewModel.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import Foundation

class NewsViewModel {
    
    weak var delegate: NewsViewControllerProtocol?
    private var articles: [Article] = []
    
    func loadArticles() {
        if let url = Bundle.main.url(forResource: "News", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let newsData = try decoder.decode(News.self, from: data)
                self.articles = newsData.articles ?? []
                delegate?.reloadArticles()
            } catch {
                delegate?.showNewsError("Failed to parse news articles.")
            }
        } else {
            delegate?.showNewsError("News data file not found.")
        }
    }
    
    func numberOfArticles() -> Int {
        return articles.count
    }
    
    func article(at index: Int) -> Article? {
        guard index >= 0 && index < articles.count else { return nil }
        return articles[index]
    }
    
    func didSelectArticle(at index: Int) {
        guard let urlString = article(at: index)?.url,
              let url = URL(string: urlString) else {
            delegate?.showNewsError("Invalid article URL.")
            return
        }
        delegate?.openArticleInBrowser(url: url)
    }
}

