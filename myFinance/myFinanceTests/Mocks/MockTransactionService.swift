//
//  MockTransactionService.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation
@testable import myFinance

struct MockTransactionService: TransactionServiceProtocol {
    var mockTransactions: [Transaction]
    var shouldThrow = false
    var errorToThrow: Error = TestError.mockError

    func fetchTransactions() async throws -> [Transaction] {
        if shouldThrow { throw errorToThrow }
        return mockTransactions
    }
}

enum TestError: Error, LocalizedError {
    case mockError

    var errorDescription: String? { "Mock error for testing" }
}

extension MockTransactionService {
    static func makeDefault() -> MockTransactionService {
        MockTransactionService(mockTransactions: [
            Transaction(
                key: "key-001",
                transactionType: .credit,
                merchantName: "Mb-credit Card/loc Pay. From - 405921512323",
                description: "Payment",
                amount: TransactionAmount(value: 2961.91, currency: "CAD"),
                postedDate: "2021-02-25",
                fromAccount: "Passport Visa Infinite",
                fromCardNumber: "4537350001688012"
            ),
            Transaction(
                key: "key-002",
                transactionType: .debit,
                merchantName: "Manulife",
                description: "Cash Advance",
                amount: TransactionAmount(value: 5.00, currency: "CAD"),
                postedDate: "2021-03-08",
                fromAccount: "Passport Visa Infinite",
                fromCardNumber: "4537350001688012"
            ),
            Transaction(
                key: "key-003",
                transactionType: .debit,
                merchantName: "Scotia Sccp Premium",
                description: "Credit card protection",
                amount: TransactionAmount(value: 26.16, currency: "CAD"),
                postedDate: "2021-03-01",
                fromAccount: "Passport Visa Infinite",
                fromCardNumber: "4537350001688"
            ),
        ])
    }
}
