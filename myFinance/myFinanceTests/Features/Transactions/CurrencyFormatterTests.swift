//
//  CurrencyFormatterTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-23
//

import Testing
import Foundation
@testable import myFinance

struct CurrencyFormatterTests {

    private let formatter = CurrencyFormatter()

    private func makeAmount(_ value: Double) -> TransactionAmount {
        TransactionAmount(value: value, currency: "CAD")
    }

    @Test
    func includesDollarSign() {
        #expect(formatter.string(from: makeAmount(100.0)).contains("$"))
    }

    @Test
    func formatsToTwoDecimalPlaces() {
        #expect(formatter.string(from: makeAmount(42.5)).contains("42.50"))
    }

    @Test("large amounts get a grouping separator")
    func groupingSeparatorForLargeAmounts() {
        #expect(formatter.string(from: makeAmount(2961.91)).contains(","))
    }
}
