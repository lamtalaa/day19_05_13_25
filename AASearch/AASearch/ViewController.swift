//
//  ViewController.swift
//  AASearch
//
//  Created by Yassine Lamtalaa on 5/8/25.
//
// Create a ViewModel that communicate between ViewController and NetworkManager

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var results: [ResultItem] = []
    var relatedTopics: [RelatedTopicItem] = []
    
    private let viewModel = SearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        tableView.backgroundColor = UIColor.systemGray5
        tableView.sectionHeaderTopPadding = 0
        
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = .clear
        searchBar.backgroundColor = .white
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.leftView = nil  // removes the search icon
        }
        
        viewModel.performSearch(for: searchBar.text)
    }
}

extension ViewController: SearchViewModelProtocol {
    func didUpdateSearchResults(results: [ResultItem], relatedTopics: [RelatedTopicItem]) {
        self.results = results
        self.relatedTopics = relatedTopics
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func didFailWithError(_ error: String) {
        print("API Error: \(error)")
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeader(in: section)
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.contentView.backgroundColor = UIColor.systemGray5
            header.textLabel?.textColor = .systemGray2
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath) as? ResultsTableViewCell

        let data = viewModel.item(at: indexPath)
        cell?.textFieldLabel.text = data.text
        cell?.firstURLLabel.text = data.url
        cell?.firstURLLabel.textColor = .gray
        cell?.firstURLLabel.font = UIFont.systemFont(ofSize: 13)

        return cell ?? UITableViewCell()
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.performSearch(for: searchBar.text)
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        viewModel.performSearch(for: searchBar.text)
    }
}

