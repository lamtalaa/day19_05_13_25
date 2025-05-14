//
//  NewsViewController.swift
//  RBSNews
//
//  RBS Tests Project on 12/10/20.
//

import UIKit
import SafariServices

protocol NewsViewControllerProtocol: AnyObject {
    func reloadArticles()
    func showNewsError(_ message: String)
    func openArticleInBrowser(url: URL)
}

class NewsViewController: UIViewController {

    @IBOutlet weak var newsTableView: UITableView!
    private let newsViewModel = NewsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News screen"
        
        newsViewModel.delegate = self
        newsTableView.dataSource = self
        newsTableView.delegate = self

        newsViewModel.loadArticles()
    }
}

extension NewsViewController: NewsViewControllerProtocol {
    
    func reloadArticles() {
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func showNewsError(_ message: String) {
        Utility.shared.showAlert(self, "Error", message)
    }
    
    func openArticleInBrowser(url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.delegate = self
        present(safariVC, animated: true)
    }
}

extension NewsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numberOfArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }

        if let article = newsViewModel.article(at: indexPath.row) {
            if let source = article.source, let title = article.title {
                cell.setupNewsCell(source: source.name, title: title)
            }
            if let imageUrl = article.urlToImage {
                cell.setupNewsImage(imageURL: imageUrl)
            }
        }

        return cell
    }
}

extension NewsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsViewModel.didSelectArticle(at: indexPath.row)
    }
}

extension NewsViewController: SFSafariViewControllerDelegate {
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
}
