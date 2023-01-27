//
//  ViewController.swift
//  iOS-Calculator
//
//  Created by Muhamad Talebi on 1/26/23.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    private let calculator = Calculator()
    private var currentExpression = ""
    private var displayValue: Double {
        get {
            return Double(displayLabel.text!)!
        }
        set {
            displayLabel.text = String(newValue)
        }
    }
    private var displayLabel = UILabel()
    private var buttons = [UIButton]()
    private var currentNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .white
        setupDisplayLabel()
        setupButtons()
    }
    
    func setupDisplayLabel() {
        view.addSubview(displayLabel)
        displayLabel.translatesAutoresizingMaskIntoConstraints = false
        displayLabel.text = "0"
        displayLabel.textAlignment = .right
        displayLabel.font = UIFont.systemFont(ofSize: 50)
        displayLabel.textColor = .black
        NSLayoutConstraint.activate([
            displayLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            displayLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            displayLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            displayLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupButtons() {
        let buttonTitles = ["AC", "+/-", "%", "÷", "7", "8", "9", "x", "4", "5", "6", "-", "1", "2", "3", "+", "0", ".", "="]
        for i in 0..<buttonTitles.count {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitles[i], for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = .white
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            let buttonX = i % 4
            let buttonY = i/4
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25),
                button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
                button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(buttonX) * view.frame.size.width/4),
                button.topAnchor.constraint(equalTo: displayLabel.bottomAnchor, constant: CGFloat(buttonY) * (view.frame.size.height * 0.1))
            ])
            buttons.append(button)
        }
    }
    
    func numberButtonPressed(_ sender: String) {
            currentExpression += sender
            displayLabel.text = currentExpression
        }
    
     func operatorButtonPressed(_ sender: String) {
            currentExpression += " " + sender + " "
            displayLabel.text = currentExpression
        }
    
     func evaluateButtonPressed() {
            displayValue = calculator.evaluateExpression(expression: currentExpression)
            currentExpression = ""
        }
     func clearButtonPressed() {
            currentExpression = ""
            displayLabel.text = "0"
        }
    
    @objc func buttonPressed(sender: UIButton){
        let buttonLabel: String = sender.titleLabel?.text ?? "Unknown Button Clicked!"
        if(buttonLabel.isNumber){
            numberButtonPressed(buttonLabel)
        }
        else if(buttonLabel == "AC"){
            clearButtonPressed()
        }
        else if(buttonLabel == "="){
            evaluateButtonPressed()
        }
        else if(buttonLabel.isOperator){
            operatorButtonPressed(buttonLabel)
        }
    }
}

