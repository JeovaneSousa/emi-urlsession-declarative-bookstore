//
//  Currency+NumberFormatter.swift
//  LearningTask-12.2
//
//  Created by rafael.rollo on 03/08/2022.
//

import Foundation

extension NumberFormatter {

    private static var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()

    static func formatToCurrency(decimal: Decimal) -> String {
        return currencyFormatter.string(from: decimal as NSDecimalNumber)!
    }

}

