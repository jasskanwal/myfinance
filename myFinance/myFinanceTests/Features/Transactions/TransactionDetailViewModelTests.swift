//
//  TransactionDetailViewModelTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-23
//

import Testing
import Foundation
@testable import myFinance

@MainActor
struct TransactionDetailViewModelTests {

    private func makeVM(type: TransactionType = .debit) -> TransactionDetailViewModel {
        TransactionDetailViewModel(
            transaction: Transaction(
                key: "test-key",
                transactionType: type,
                merchantName: "Scotiabank",
                description: nil,
                amount: TransactionAmount(value: 1234.56, currency: "CAD"),
                postedDate: "2021-02-25",
                fromAccount: "Passport Visa Infinite",
                fromCardNumber: "4537350001688012"
            ),
            currencyFormatter: MockCurrencyFormatter()
        )
    }

    @Test
    func isCreditForCreditType() {
        #expect(makeVM(type: .credit).isCredit)
    }

    @Test
    func isNotCreditForDebitType() {
        #expect(!makeVM(type: .debit).isCredit)
    }

    // MARK: - Sections

    @Test
    func hasThreeSections() {
        #expect(makeVM().sections.count == 3)
    }

    @Test("first section carries isCredit flag")
    func headerSectionFlag() {
        let vm = makeVM(type: .credit)
        if case .header(let isCredit, _) = vm.sections[0] {
            #expect(isCredit == true)
        } else {
            Issue.record("Expected header section at index 0")
        }
    }

    @Test("detail section has two rows")
    func detailSectionRowCount() {
        if case .transactionDetail(let rows) = makeVM().sections[1] {
            #expect(rows.count == 2)
        } else {
            Issue.record("Expected transactionDetail section at index 1")
        }
    }

    // MARK: - Row values

    @Test("from row shows last 4 card digits")
    func cardSuffixInFromRow() {
        if case .transactionDetail(let rows) = makeVM().sections[1] {
            #expect(rows[0].secondaryValue == "(8012)")
        } else {
            Issue.record("Could not access transactionDetail rows")
        }
    }

    @Test("amount row uses injected formatter")
    func amountFormattedCorrectly() {
        if case .transactionDetail(let rows) = makeVM().sections[1] {
            #expect(rows[1].value == "$1234.56")
        } else {
            Issue.record("Could not access transactionDetail rows")
        }
    }

    // MARK: - Strings

    @Test
    func navigationTitle() {
        #expect(makeVM().navigationTitle == "Transaction Detail")
    }

    @Test
    func closeButtonTitle() {
        #expect(makeVM().closeButtonTitle == "Close")
    }

    @Test
    func showMoreAndLessLabels() {
        let vm = makeVM()
        #expect(vm.noticeShowMoreLabel == "Show more")
        #expect(vm.noticeShowLessLabel == "Show less")
    }
}
