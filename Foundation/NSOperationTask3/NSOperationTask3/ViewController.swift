//
//  ViewController.swift
//  NSOperationTask3
//
//  Created by Mateusz Krówczyński on 29/07/2025.
//

import UIKit

final class ViewController: UIViewController {
    private let multithreadingTestsService = MultithreadingTestsService(queue: OperationQueue())
    
    private lazy var scenarioOneButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scenario One", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scenarioTwoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scenario Two", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addActions()
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(scenarioOneButton)
        view.addSubview(scenarioTwoButton)
        
        let viewOffset: CGFloat = 60
        let padding: CGFloat = 20
        let buttonHeight: CGFloat = 50
        let buttonWidth: CGFloat = 200
        
        NSLayoutConstraint.activate([
            scenarioOneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scenarioOneButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -viewOffset),
            scenarioOneButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            scenarioOneButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            scenarioTwoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scenarioTwoButton.topAnchor.constraint(equalTo: scenarioOneButton.bottomAnchor, constant: padding),
            scenarioTwoButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            scenarioTwoButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    private func addActions() {
        scenarioOneButton.addTarget(self, action: #selector(scenarioOneTapped), for: .touchUpInside)
        scenarioTwoButton.addTarget(self, action: #selector(scenarioTwoTapped), for: .touchUpInside)
    }
    
    @objc func scenarioOneTapped() {
        multithreadingTestsService.runScenarioOne()
    }
    
    @objc func scenarioTwoTapped() {
        multithreadingTestsService.runScenarioTwo()
    }
}

#Preview {
    ViewController()
}

