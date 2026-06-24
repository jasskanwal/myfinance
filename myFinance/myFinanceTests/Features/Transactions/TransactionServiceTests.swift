//
//  TransactionServiceTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Testing
import Foundation
@testable import myFinance

struct TransactionServiceTests {

    private func makeTransaction(key: String = UUID().uuidString) -> Transaction {
        Transaction(
            key: key,
            transactionType: .debit,
            merchantName: "Test Merchant",
            description: nil,
            amount: TransactionAmount(value: 10.0, currency: "CAD"),
            postedDate: "2021-05-31",
            fromAccount: "Passport Visa Infinite",
            fromCardNumber: "4537350001688012"
        )
    }

    private func makeService(transactions: [Transaction] = [], shouldThrow: Bool = false) -> TransactionService {
        TransactionService(networkService: MockNetworkService(transactions: transactions, shouldThrow: shouldThrow))
    }

    @Test("unwraps response envelope")
    func unwrapsEnvelope() async throws {
        let expected = [makeTransaction(key: "k1"), makeTransaction(key: "k2")]
        let result = try await makeService(transactions: expected).fetchTransactions()
        #expect(result.count == expected.count)
    }

    @Test("propagates network errors")
    func propagatesNetworkError() async {
        await #expect(throws: Error.self) {
            try await makeService(shouldThrow: true).fetchTransactions()
        }
    }

    @Test
    func preservesOrder() async throws {
        let transactions = ["First", "Second", "Third"].map { makeTransaction(key: $0) }
        let result = try await makeService(transactions: transactions).fetchTransactions()
        #expect(result.map { $0.key } == transactions.map { $0.key })
    }
}
