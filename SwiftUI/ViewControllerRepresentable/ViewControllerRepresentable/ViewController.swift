//
//  ViewController.swift
//  ViewControllerRepresentable
//
//  Created by Mateusz Krówczyński on 03/08/2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private lazy var helloUIKitLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello, from UIKit!"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private func setupUI() {
        view.addSubview(helloUIKitLabel)
        
        NSLayoutConstraint.activate([
            helloUIKitLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            helloUIKitLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

#Preview {
    ViewController()
}
