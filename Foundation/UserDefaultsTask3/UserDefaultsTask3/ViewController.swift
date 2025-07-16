//
//  ViewController.swift
//  UserDefaultsTask3
//
//  Created by Mateusz Krówczyński on 16/07/2025.
//

import UIKit

final class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource {
    private let userDefaults = UserDefaults.standard
    private var savedSearchTermsKey: String = "savedSearchTermsKey"
    
    private var searchTerms: [String] {
        get {
            userDefaults.stringArray(forKey: savedSearchTermsKey) ?? []
        }
        set {
            userDefaults.set(newValue, forKey: savedSearchTermsKey)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        title = "Search History"
    }
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var searchHistoryTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    private lazy var clearButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearSearchHistory))
        button.tintColor = .systemRed
        return button
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryCell") ?? UITableViewCell(style: .default, reuseIdentifier: "SearchHistoryCell")
        cell.textLabel?.text = searchTerms[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        
        var terms = searchTerms
        if !terms.contains(searchText) {
            if terms.count == 5 {
                terms.removeFirst()
                terms.append(searchText)
                searchTerms = terms
            } else {
                terms.append(searchText)
                searchTerms = terms
            }
        }
        
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        searchHistoryTableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(searchBar)
        view.addSubview(searchHistoryTableView)
        navigationItem.rightBarButtonItem = clearButton
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            searchHistoryTableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchHistoryTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchHistoryTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchHistoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc private func clearSearchHistory() {
        guard !searchTerms.isEmpty else { return }
        searchTerms.removeAll()
        searchHistoryTableView.reloadData()
    }
}

#Preview {
    ViewController()
}

