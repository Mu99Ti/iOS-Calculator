//
//  Extension.swift
//  iOS-Calculator
//
//  Created by Muhamad Talebi on 1/26/23.
//

import Foundation

private var operators: [String] = ["=","+","x","÷"]

extension String {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }

    var isOperator: Bool {
        return !isNumber
    }
}

