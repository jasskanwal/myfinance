//
//  CurrencyFormatter.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-23
//

import Foundation

protocol CurrencyFormatterProtocol {
    func string(from amount: TransactionAmount) -> String
}

final class CurrencyFormatter: CurrencyFormatterProtocol {
    private let formatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.locale = Locale(identifier: "en_US")
        return f
    }()

    func string(from amount: TransactionAmount) -> String {
        formatter.string(from: NSNumber(value: amount.value)) ?? "$\(String(format: "%.2f", amount.value))"
    }
}
