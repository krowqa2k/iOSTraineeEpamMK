//
//  ViewController.swift
//  CalculatorApp
//
//  Created by Mateusz Krówczyński on 19/06/2025.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDisplayLabel()
        createNumberButtons()
        createOperationButtons()
    }
    
    var displayLabel: UILabel!
    
    var button0: UIButton!
    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var button4: UIButton!
    var button5: UIButton!
    var button6: UIButton!
    var button7: UIButton!
    var button8: UIButton!
    var button9: UIButton!
    
    var buttonPlus: UIButton!
    var buttonMinus: UIButton!
    var buttonMultiply: UIButton!
    var buttonDivide: UIButton!
    var buttonEquals: UIButton!
    var buttonClear: UIButton!
    
    var currentNumber = ""
    var previousNumber = ""
    var currentOperation = ""
    var isTypingNumber = false
    
    func createDisplayLabel() {
        displayLabel = UILabel.init(frame: CGRect(x: 50, y: 100, width: 300, height: 60))
        displayLabel.text = "0"
        displayLabel.textAlignment = .right
        displayLabel.backgroundColor = .lightGray
        displayLabel.textColor = .black
        displayLabel.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(displayLabel)
    }
    
    func createNumberButtons() {
        button0 = UIButton.init(frame: CGRect(x: 130, y: 500, width: 60, height: 60))
        button0.setTitle("0", for: .normal)
        button0.backgroundColor = .gray
        button0.addAction(UIAction { _ in
            self.numberPressed(number: "0")
        }, for: .touchUpInside)
        view.addSubview(button0)
        
        button1 = UIButton.init(frame: CGRect(x: 50, y: 420, width: 60, height: 60))
        button1.setTitle("1", for: .normal)
        button1.backgroundColor = .gray
        button1.addAction(UIAction { _ in
            self.numberPressed(number: "1")
        }, for: .touchUpInside)
        view.addSubview(button1)
        
        button2 = UIButton.init(frame: CGRect(x: 130, y: 420, width: 60, height: 60))
        button2.setTitle("2", for: .normal)
        button2.backgroundColor = .gray
        button2.addAction(UIAction { _ in
            self.numberPressed(number: "2")
        }, for: .touchUpInside)
        view.addSubview(button2)
        
        button3 = UIButton.init(frame: CGRect(x: 210, y: 420, width: 60, height: 60))
        button3.setTitle("3", for: .normal)
        button3.backgroundColor = .gray
        button3.addAction(UIAction { _ in
            self.numberPressed(number: "3")
        }, for: .touchUpInside)
        view.addSubview(button3)
        
        button4 = UIButton.init(frame: CGRect(x: 50, y: 340, width: 60, height: 60))
        button4.setTitle("4", for: .normal)
        button4.backgroundColor = .gray
        button4.addAction(UIAction { _ in
            self.numberPressed(number: "4")
        }, for: .touchUpInside)
        view.addSubview(button4)
        
        button5 = UIButton.init(frame: CGRect(x: 130, y: 340, width: 60, height: 60))
        button5.setTitle("5", for: .normal)
        button5.backgroundColor = .gray
        button5.addAction(UIAction { _ in
            self.numberPressed(number: "5")
        }, for: .touchUpInside)
        view.addSubview(button5)
        
        button6 = UIButton.init(frame: CGRect(x: 210, y: 340, width: 60, height: 60))
        button6.setTitle("6", for: .normal)
        button6.backgroundColor = .gray
        button6.addAction(UIAction { _ in
            self.numberPressed(number: "6")
        }, for: .touchUpInside)
        view.addSubview(button6)
        
        button7 = UIButton.init(frame: CGRect(x: 50, y: 260, width: 60, height: 60))
        button7.setTitle("7", for: .normal)
        button7.backgroundColor = .gray
        button7.addAction(UIAction { _ in
            self.numberPressed(number: "7")
        }, for: .touchUpInside)
        view.addSubview(button7)
        
        button8 = UIButton.init(frame: CGRect(x: 130, y: 260, width: 60, height: 60))
        button8.setTitle("8", for: .normal)
        button8.backgroundColor = .gray
        button8.addAction(UIAction { _ in
            self.numberPressed(number: "8")
        }, for: .touchUpInside)
        view.addSubview(button8)
        
        button9 = UIButton.init(frame: CGRect(x: 210, y: 260, width: 60, height: 60))
        button9.setTitle("9", for: .normal)
        button9.backgroundColor = .gray
        button9.addAction(UIAction { _ in
            self.numberPressed(number: "9")
        }, for: .touchUpInside)
        view.addSubview(button9)
    }
    
    func createOperationButtons() {
        buttonPlus = UIButton.init(frame: CGRect(x: 290, y: 420, width: 60, height: 60))
        buttonPlus.setTitle("+", for: .normal)
        buttonPlus.backgroundColor = .orange
        buttonPlus.addAction(UIAction { _ in
            self.operationPressed(operation: "+")
        }, for: .touchUpInside)
        view.addSubview(buttonPlus)
        
        buttonMinus = UIButton.init(frame: CGRect(x: 290, y: 340, width: 60, height: 60))
        buttonMinus.setTitle("-", for: .normal)
        buttonMinus.backgroundColor = .orange
        buttonMinus.addAction(UIAction { _ in
            self.operationPressed(operation: "-")
        }, for: .touchUpInside)
        view.addSubview(buttonMinus)
        
        buttonMultiply = UIButton.init(frame: CGRect(x: 290, y: 260, width: 60, height: 60))
        buttonMultiply.setTitle("*", for: .normal)
        buttonMultiply.backgroundColor = .orange
        buttonMultiply.addAction(UIAction { _ in
            self.operationPressed(operation: "*")
        }, for: .touchUpInside)
        view.addSubview(buttonMultiply)
        
        buttonDivide = UIButton.init(frame: CGRect(x: 290, y: 180, width: 60, height: 60))
        buttonDivide.setTitle("/", for: .normal)
        buttonDivide.backgroundColor = .orange
        buttonDivide.addAction(UIAction { _ in
            self.operationPressed(operation: "/")
        }, for: .touchUpInside)
        view.addSubview(buttonDivide)
        
        buttonEquals = UIButton.init(frame: CGRect(x: 290, y: 500, width: 60, height: 60))
        buttonEquals.setTitle("=", for: .normal)
        buttonEquals.backgroundColor = .orange
        buttonEquals.addAction(UIAction { _ in
            self.equalsPressed()
        }, for: .touchUpInside)
        view.addSubview(buttonEquals)
        
        buttonClear = UIButton.init(frame: CGRect(x: 50, y: 180, width: 60, height: 60))
        buttonClear.setTitle("C", for: .normal)
        buttonClear.backgroundColor = .red
        buttonClear.addAction(UIAction { _ in
            self.clearPressed()
        }, for: .touchUpInside)
        view.addSubview(buttonClear)
    }
    
    func numberPressed(number: String) {
        if isTypingNumber {
            currentNumber = currentNumber + number
        } else {
            currentNumber = number
            isTypingNumber = true
        }
        displayLabel.text = currentNumber
    }
    
    func operationPressed(operation: String) {
        if isTypingNumber {
            previousNumber = currentNumber
            currentOperation = operation
            isTypingNumber = false
        }
    }
    
    func equalsPressed() {
        if previousNumber != "" && currentNumber != "" && currentOperation != "" {
            let prev = Double(previousNumber)!
            let current = Double(currentNumber)!
            var result: Double = 0
            
            if currentOperation == "+" {
                result = prev + current
            } else if currentOperation == "-" {
                result = prev - current
            } else if currentOperation == "*" {
                result = prev * current
            } else if currentOperation == "/" {
                if current == 0 {
                    displayLabel.text = "Dividing by zero is not allowed"
                    clearAll()
                    return
                }
                result = prev / current
            }
            
            displayLabel.text = String(result)
            currentNumber = String(result)
            previousNumber = ""
            currentOperation = ""
            isTypingNumber = false
        }
    }
    
    func clearPressed() {
        clearAll()
        displayLabel.text = "0"
    }
    
    func clearAll() {
        currentNumber = ""
        previousNumber = ""
        currentOperation = ""
        isTypingNumber = false
    }
}

#Preview {
    ViewController()
}
