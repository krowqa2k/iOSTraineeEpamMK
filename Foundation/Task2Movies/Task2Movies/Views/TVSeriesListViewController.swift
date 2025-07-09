//
//  TVSeriesListViewController.swift
//  Task2Movies
//
//  Created by Mateusz Krówczyński on 09/07/2025.
//

import UIKit

final class TVSeriesListViewController: UIViewController {

    private let tableView = UITableView()
    private let seriesService: NetworkingService
    private var tvSeries: [TVSeriesModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Home"
        setupUI()
        fetchTVSeries()
    }
    
    init(seriesService: NetworkingService) {
        self.seriesService = seriesService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        
        tableView.register(TVSeriesCell.self, forCellReuseIdentifier: "TVSeriesCell")
        
        tableView.tableFooterView = UIView()
    }

    private func fetchTVSeries() {
        Task {
            do {
                let newTVSeries = try await seriesService.fetchTopRatedSeries()
                self.tvSeries.append(contentsOf: newTVSeries)
                self.tableView.reloadData()
            } catch {
                print("Error fetching TV series: \(error.localizedDescription)")
            }
        }
    }
}

extension TVSeriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvSeries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVSeriesCell", for: indexPath) as? TVSeriesCell else {
            return UITableViewCell()
        }

        let series = tvSeries[indexPath.row]
        cell.configure(with: series, apiService: seriesService)
        return cell
    }
}

#Preview {
    TVSeriesListViewController(seriesService: NetworkingService())
}
