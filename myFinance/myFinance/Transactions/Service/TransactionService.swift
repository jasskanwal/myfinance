//
//  TransactionService.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

final class TransactionService: TransactionServiceProtocol {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func fetchTransactions() async throws -> [Transaction] {
        let response = try await networkService.fetch(TransactionListResponse.self, from: "transaction-list")
        return response.transactions
    }
}
