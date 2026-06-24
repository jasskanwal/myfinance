//
//  TransactionModelTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Testing
import Foundation
@testable import myFinance

struct TransactionModelTests {

    @Test
    func idMatchesKey() {
        #expect(makeTransaction(key: "unique-key-abc").id == "unique-key-abc")
    }

    @Test
    func descriptionCanBeNil() {
        #expect(makeTransaction(description: nil).description == nil)
    }

    @Test("falls back to raw string if date format is unrecognised")
    func formattedDateFallback() {
        #expect(makeTransaction(postedDate: "not-a-date").formattedDate == "not-a-date")
    }

    @Test("raw values match expected JSON strings")
    func transactionTypeRawValues() {
        #expect(TransactionType.debit.rawValue  == "DEBIT")
        #expect(TransactionType.credit.rawValue == "CREDIT")
    }

    @Test("same key means equal")
    func equalityByKey() {
        #expect(makeTransaction(key: "same-key") == makeTransaction(key: "same-key"))
    }

    // MARK: - Helpers

    private func makeTransaction(
        key: String = "test-key",
        description: String? = "Test description",
        postedDate: String = "2021-05-31"
    ) -> Transaction {
        Transaction(
            key: key,
            transactionType: .debit,
            merchantName: "Test Merchant",
            description: description,
            amount: TransactionAmount(value: 10.0, currency: "CAD"),
            postedDate: postedDate,
            fromAccount: "Passport Visa Infinite",
            fromCardNumber: "4537350001688012"
        )
    }
}
