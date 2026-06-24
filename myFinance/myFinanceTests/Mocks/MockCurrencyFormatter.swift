//
//  MockCurrencyFormatter.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-23
//

import Foundation
@testable import myFinance

struct MockCurrencyFormatter: CurrencyFormatterProtocol {
    func string(from amount: TransactionAmount) -> String {
        "$\(String(format: "%.2f", amount.value))"
    }
}
