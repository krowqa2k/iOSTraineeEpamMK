//
//  TVSeriesCell.swift
//  Task2Movies
//
//  Created by Mateusz Krówczyński on 09/07/2025.
//

import UIKit

final class TVSeriesCell: UITableViewCell {

    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let firstAirDateLabel = UILabel()
    let ratingLabel = UILabel()
    let countriesLabel = UILabel()
    let popularityLabel = UILabel()
    let overviewLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented - use programmatic initialization")
    }

    private func setupCellUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.backgroundColor = .systemGray5
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .label

        let labelFont = UIFont.systemFont(ofSize: 13)
        
        firstAirDateLabel.font = labelFont
        ratingLabel.font = labelFont
        countriesLabel.font = labelFont
        popularityLabel.font = labelFont
        
        overviewLabel.font = UIFont.systemFont(ofSize: 14)
        overviewLabel.textColor = .label
        overviewLabel.numberOfLines = 0
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(firstAirDateLabel)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(countriesLabel)
        contentView.addSubview(popularityLabel)
        contentView.addSubview(overviewLabel)

        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstAirDateLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        countriesLabel.translatesAutoresizingMaskIntoConstraints = false
        popularityLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 150),

            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            firstAirDateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            firstAirDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            firstAirDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            ratingLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            ratingLabel.topAnchor.constraint(equalTo: firstAirDateLabel.bottomAnchor, constant: 4),
            ratingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            countriesLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            countriesLabel.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 4),
            countriesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            popularityLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            popularityLabel.topAnchor.constraint(equalTo: countriesLabel.bottomAnchor, constant: 4),
            popularityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImageView.image = nil
        titleLabel.text = nil
        firstAirDateLabel.text = nil
        ratingLabel.text = nil
        countriesLabel.text = nil
        popularityLabel.text = nil
        overviewLabel.text = nil
    }

    func configure(with series: TVSeriesModel, apiService: NetworkingService) {
        titleLabel.text = series.name
        firstAirDateLabel.text = "First Air Date - \(series.firstAirDate)"
        ratingLabel.text = "Rating - \(String(format: "%.1f", series.voteAverage))"
        countriesLabel.text = "Countries - \(series.originCountry.joined(separator: ", "))"
        popularityLabel.text = "Popularity - \(Int(series.popularity))"
        overviewLabel.text = series.overview
        
        Task {
            let imagePath = series.posterPath
            
            do {
                let image = try await apiService.fetchImage(path: imagePath)
                self.posterImageView.image = image
            } catch {
                print("Error loading image for \(series.name): \(error.localizedDescription)")
                self.posterImageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
            }
        }
    }
}
