//
//  Task4ViewController.swift
//  AutolatoutPracticalTasks
//
//  Created by Kakhaberi Kiknadze on 20.03.25.
//

import UIKit

// Create a view with two subviews aligned vertically when in Compact width, Regular height mode.
// If the orientation changes to Compact-Compact, same 2 subviews should be aligned horizontally.
// Hou can use iPhone 16 simulator for testing.
final class Task4ViewController: UIViewController {
    private let redView = UIView()
    private let blueView = UIView()
    
    private let mainStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupSubviews()
        setupStackView()
        
        NSLayoutConstraint.activate(
            [
                mainStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                mainStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
                mainStackView.leadingAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                mainStackView.trailingAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                mainStackView.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                mainStackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
            ]
        )
        
        registerForTraitChanges()
        
        updateStackViewAxis(for: traitCollection)
    }

    private func setupSubviews() {
        redView.backgroundColor = .systemRed
        redView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                redView.widthAnchor.constraint(equalToConstant: 150),
                redView.heightAnchor.constraint(equalToConstant: 150)
            ]
        )
        
        blueView.backgroundColor = .systemBlue
        blueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                blueView.widthAnchor.constraint(equalToConstant: 150),
                blueView.heightAnchor.constraint(equalToConstant: 150)
            ]
        )
    }
    
    private func setupStackView() {
        mainStackView.addArrangedSubview(redView)
        mainStackView.addArrangedSubview(blueView)
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fillEqually
        mainStackView.alignment = .center
        mainStackView.spacing = 20
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainStackView)
    }
    
    private func registerForTraitChanges() {
        let sizeTraits: [UITrait] = [UITraitVerticalSizeClass.self, UITraitHorizontalSizeClass.self]
        registerForTraitChanges(sizeTraits) { [weak self] (traitSelf: Task4ViewController, previousTraitCollection: UITraitCollection) in
            print("Trait collection changed: Horizontal: \(traitSelf.traitCollection.horizontalSizeClass == .compact ? "Compact" : "Regular"), Vertical: \(traitSelf.traitCollection.verticalSizeClass == .compact ? "Compact" : "Regular")")
            
            self?.updateStackViewAxis(for: traitSelf.traitCollection)
        }
    }
    
    private func updateStackViewAxis(for traitCollection: UITraitCollection) {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            mainStackView.axis = .vertical
            print("Detected: Compact width, Regular height -> Vertical layout")
        }
        else if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .compact {
            mainStackView.axis = .horizontal
            print("Detected: Compact-Compact -> Horizontal layout")
        }
        else {
            mainStackView.axis = .vertical
            print("Detected: Other trait collection -> Default Vertical layout")
        }
    }
}

#Preview {
    Task4ViewController()
}
