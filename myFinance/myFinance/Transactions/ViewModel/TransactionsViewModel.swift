//
//  TransactionsViewModel.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI
import Combine

@MainActor
final class TransactionsViewModel: ObservableObject {

    enum ViewState {
        case loading
        case error(String)
        case loaded([Transaction])
    }

    @Published var navigationPath = NavigationPath()
    @Published private(set) var transactions: [Transaction] = []
    private var isLoading = false
    @Published private(set) var errorMessage: String?

    let navigationTitle = "Transaction List"

    var navigate: ((TransactionRoute) -> Void)?
    var makeDetailViewModel: ((Transaction) -> TransactionDetailViewModel)?

    private let transactionService: TransactionServiceProtocol

    init(transactionService: TransactionServiceProtocol) {
        self.transactionService = transactionService
    }

    func loadTransactions() async {
        isLoading = true
        errorMessage = nil
        do {
            transactions = try await transactionService.fetchTransactions()
        } catch {
            errorMessage = error.localizedDescription
            transactions = []
        }
        isLoading = false
    }

    var viewState: ViewState {
        if isLoading { return .loading }
        if let error = errorMessage { return .error(error) }
        return .loaded(transactions)
    }

    func selectTransaction(_ transaction: Transaction) {
        guard let vm = makeDetailViewModel?(transaction) else { return }
        navigate?(.detail(vm))
    }


}
