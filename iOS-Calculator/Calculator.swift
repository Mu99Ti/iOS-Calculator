//
//  Calculator.swift
//  iOS-Calculator
//
//  Created by Muhamad Talebi on 1/26/23.
//

import Foundation

class Calculator {
    private var outputQueue: [String] = []
    private var operatorStack: [String] = []
    private let precedence: [String: Int] = ["+": 1, "-": 1, "x": 2, "÷": 2, "^": 3]
    private let associativity: [String: String] = ["+": "Left", "-": "Left", "*": "Left", "/": "Left", "^": "Right"]
    let separator = " "
    func evaluateExpression(expression: String) -> Double {
        outputQueue = []
        operatorStack = []
        let tokens = expression.split(separator: Character(separator)).map { String($0) }
        print(tokens.count)
        print(tokens)
        for token in tokens {
            if let value = Double(token) {
                outputQueue.append(token)
            } else if token == "(" {
                operatorStack.append(token)
            } else if token == ")" {
                while operatorStack.last != "(" {
                    outputQueue.append(operatorStack.removeLast())
                }
                operatorStack.removeLast()
            } else if precedence.keys.contains(token) {
                while operatorStack.count > 0 && precedence[token]! <= precedence[operatorStack.last!]! && associativity[token] == "Left" {
                    outputQueue.append(operatorStack.removeLast())
                }
                operatorStack.append(token)
            }
        }
        while operatorStack.count > 0 {
            outputQueue.append(operatorStack.removeLast())
        }
        
        return evaluateRPN(outputQueue)
    }
    
    private func evaluateRPN(_ rpn: [String]) -> Double {
        var stack: [Double] = []
        for token in rpn {
            if let value = Double(token) {
                stack.append(value)
            } else {
                let op2 = stack.removeLast()
                let op1 = stack.removeLast()
                switch token {
                case "+": stack.append(op1 + op2)
                case "-": stack.append(op1 - op2)
                case "x": stack.append(op1 * op2)
                case "÷": stack.append(op1 / op2)
                case "^": stack.append(pow(op1, op2))
                default: break
                }       
            }
        }
        return stack.last!
    }
    
    
}
