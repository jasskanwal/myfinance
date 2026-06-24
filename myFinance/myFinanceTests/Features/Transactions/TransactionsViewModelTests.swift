//
//  TransactionsViewModelTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Testing
import Foundation
@testable import myFinance

@MainActor
struct TransactionsViewModelTests {

    private func makeVM(service: MockTransactionService = MockTransactionService(mockTransactions: [])) -> TransactionsViewModel {
        TransactionsViewModel(transactionService: service)
    }

    private func makeTransaction(key: String = UUID().uuidString, type: TransactionType = .debit, amount: Double = 100.0) -> Transaction {
        Transaction(
            key: key,
            transactionType: type,
            merchantName: "Test Merchant",
            description: nil,
            amount: TransactionAmount(value: amount, currency: "CAD"),
            postedDate: "2021-05-31",
            fromAccount: "Passport Visa Infinite",
            fromCardNumber: "4537350001688012"
        )
    }

    @Test
    func startsWithEmptyList() {
        #expect(makeVM().transactions.isEmpty)
    }

    @Test("populates list on load")
    func loadsTransactions() async {
        let service = MockTransactionService.makeDefault()
        let vm = makeVM(service: service)
        await vm.loadTransactions()
        #expect(vm.transactions.count == service.mockTransactions.count)
    }

    @Test("sets error message on failure")
    func setsErrorOnFailure() async {
        let vm = makeVM(service: MockTransactionService(mockTransactions: [], shouldThrow: true))
        await vm.loadTransactions()
        #expect(vm.errorMessage != nil)
    }

    // MARK: - ViewState

    @Test
    func viewStateIsErrorOnFailure() async {
        let vm = makeVM(service: MockTransactionService(mockTransactions: [], shouldThrow: true))
        await vm.loadTransactions()
        if case .error = vm.viewState { } else {
            Issue.record("Expected .error viewState after failure")
        }
    }

    @Test
    func viewStateIsLoadedOnSuccess() async {
        let vm = makeVM(service: MockTransactionService.makeDefault())
        await vm.loadTransactions()
        if case .loaded(let transactions) = vm.viewState {
            #expect(!transactions.isEmpty)
        } else {
            Issue.record("Expected .loaded viewState after success")
        }
    }

    @Test("navigates to detail when factory is wired up")
    func selectTransactionCallsNavigate() {
        let vm = makeVM()
        var navigatedRoute: TransactionRoute?
        vm.makeDetailViewModel = { transaction in
            TransactionDetailViewModel(transaction: transaction, currencyFormatter: MockCurrencyFormatter())
        }
        vm.navigate = { route in navigatedRoute = route }
        vm.selectTransaction(makeTransaction())
        if case .detail = navigatedRoute { } else {
            Issue.record("Expected .detail route from selectTransaction")
        }
    }
}
