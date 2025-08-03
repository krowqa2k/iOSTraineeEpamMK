//
//  ViewController.swift
//  HostingController
//
//  Created by Mateusz Krówczyński on 03/08/2025.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addActions()
        setupUI()
    }
    
    private lazy var goToSwiftUIViewButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to SwiftUI View", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 12
        return button
    }()
    
    @objc private func goToSwiftUIView() {
        let vc = UIHostingController(rootView: TextView())
        present(vc, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(goToSwiftUIViewButton)
        goToSwiftUIViewButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            goToSwiftUIViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToSwiftUIViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            goToSwiftUIViewButton.heightAnchor.constraint(equalToConstant: 50),
            goToSwiftUIViewButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func addActions() {
        goToSwiftUIViewButton.addTarget(self, action: #selector(goToSwiftUIView), for: .touchUpInside)
    }
}

#Preview {
    ViewController()
}

