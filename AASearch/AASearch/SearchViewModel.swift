//
//  SearchViewModel.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/13/25.
//

import Foundation

protocol SearchViewModelProtocol: AnyObject {
    func didUpdateSearchResults(results: [ResultItem], relatedTopics: [RelatedTopicItem])
    func didFailWithError(_ error: String)
}

class SearchViewModel {
    weak var delegate: SearchViewModelProtocol?
    private let networkManager = NetworkManager()
    
    private var results: [ResultItem] = []
    private var relatedTopics: [RelatedTopicItem] = []

    func performSearch(for query: String?) {
        guard let query = query, !query.isEmpty else { return }

        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = "https://api.duckduckgo.com/?q=\(encodedQuery)&format=json&pretty=1"

        Task {
            do {
                let response = try await networkManager.doApi(endPoint: url, modelName: SearchResponse.self)
                self.results = response.Results
                self.relatedTopics = response.RelatedTopics
                delegate?.didUpdateSearchResults(results: self.results, relatedTopics: self.relatedTopics)
            } catch {
                delegate?.didFailWithError("Failed to fetch or parse data.")
            }
        }
    }

    func numberOfSections() -> Int {
        return 2
    }

    func titleForHeader(in section: Int) -> String? {
        return section == 0 ? "RESULTS" : "RELATED TOPICS"
    }

    func numberOfRows(in section: Int) -> Int {
        return section == 0 ? results.count : relatedTopics.count
    }

    func item(at indexPath: IndexPath) -> (text: String, url: String) {
        if indexPath.section == 0 {
            let item = results[indexPath.row]
            return (item.Text, item.FirstURL)
        } else {
            let topic = relatedTopics[indexPath.row]
            return (topic.Text, topic.FirstURL)
        }
    }
}


