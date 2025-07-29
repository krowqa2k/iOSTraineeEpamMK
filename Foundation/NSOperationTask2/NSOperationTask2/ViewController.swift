//
//  ViewController.swift
//  NSOperationTask2
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
    
    private lazy var scenarioThreeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scenario Three", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scenarioFourButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Scenario Four", for: .normal)
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
        view.addSubview(scenarioThreeButton)
        view.addSubview(scenarioFourButton)
        
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
            scenarioTwoButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            scenarioThreeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scenarioThreeButton.topAnchor.constraint(equalTo: scenarioTwoButton.bottomAnchor, constant: padding),
            scenarioThreeButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            scenarioThreeButton.heightAnchor.constraint(equalToConstant: buttonHeight),
            
            scenarioFourButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scenarioFourButton.topAnchor.constraint(equalTo: scenarioThreeButton.bottomAnchor, constant: padding),
            scenarioFourButton.widthAnchor.constraint(equalToConstant: buttonWidth),
            scenarioFourButton.heightAnchor.constraint(equalToConstant: buttonHeight)
        ])
    }
    
    private func addActions() {
        scenarioOneButton.addTarget(self, action: #selector(runScenarioOne), for: .touchUpInside)
        scenarioTwoButton.addTarget(self, action: #selector(runScenario2), for: .touchUpInside)
        scenarioThreeButton.addTarget(self, action: #selector(runScenarioThree), for: .touchUpInside)
        scenarioFourButton.addTarget(self, action: #selector(runScenarioFour), for: .touchUpInside)
    }
    
    @objc func runScenarioOne() {
        multithreadingTestsService.scenarioOneTest()
    }
    
    @objc func runScenario2() {
        multithreadingTestsService.scenarioTwoTest()
    }
    
    @objc func runScenarioThree() {
        multithreadingTestsService.scenarioThreeTest()
    }
    
    @objc func runScenarioFour() {
        multithreadingTestsService.scenarioFourTest()
    }
}

#Preview {
    ViewController()
}

