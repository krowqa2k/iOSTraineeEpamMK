//
//  ViewController.swift
//  BundleTask1
//
//  Created by Mateusz Krówczyński on 13/07/2025.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        addActions()
        loadTextFromFile()
    }
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your text here..."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Load text", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let fileName: String = "uiKitText.txt"
    
    private func setupUI() {
        view.addSubview(textField)
        view.addSubview(saveButton)
        view.addSubview(loadButton)
        view.addSubview(textView)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.widthAnchor.constraint(equalToConstant: 150),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            
            loadButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            loadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loadButton.widthAnchor.constraint(equalToConstant: 150),
            loadButton.heightAnchor.constraint(equalToConstant: 44),
            
            textView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func addActions() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        loadButton.addTarget(self, action: #selector(loadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func saveButtonTapped() {
        guard let textToSave = textField.text, !textToSave.isEmpty else {
            print("Text field is empty. Please enter some text.")
            return
        }
        saveTextToFile(textToSave)
    }
    
    @objc private func loadButtonTapped() {
        loadTextFromFile()
    }
    
    private func getFileURL() -> URL? {
        guard let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let fileURL = documentsDirectoryURL.appendingPathComponent(fileName)
        return fileURL
    }
    
    private func saveTextToFile(_ text: String) {
        guard let fileURL = getFileURL() else { return }
        
        let fileManager = FileManager.default
        let filePath = fileURL.path
        
        if fileManager.fileExists(atPath: filePath) {
            do {
                try fileManager.removeItem(atPath: filePath)
            } catch {
                print("Error removing existing file: \(error.localizedDescription)")
            }
        }
        
        if fileManager.createFile(atPath: filePath, contents: text.data(using: .utf8)) {
            print("File saved successfully at \(filePath)")
        } else {
            print("Failed to save file at \(filePath)")
        }
    }
    
    private func loadTextFromFile() {
        guard let fileURL = getFileURL() else { return }
        
        let fileManager = FileManager.default
        let filePath = fileURL.path
        
        guard fileManager.fileExists(atPath: filePath) else {
            print("File does not exist at \(filePath)")
            return
        }
        
        guard let fileData = fileManager.contents(atPath: filePath) else {
            print("Failed to read file at \(filePath)")
            return
        }
        
        if let loadedText = String(data: fileData, encoding: .utf8) {
            textView.text = loadedText
        } else {
            textView.text = ""
            print("Failed to load text from file at \(filePath)")
        }
    }
}

#Preview {
    ViewController()
}
