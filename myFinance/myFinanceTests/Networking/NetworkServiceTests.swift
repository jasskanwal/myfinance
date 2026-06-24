//
//  NetworkServiceTests.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Testing
import Foundation
@testable import myFinance

struct NetworkServiceTests {

    @Test("fetch throws for a missing JSON file")
    func fetchThrowsForMissingResource() async {
        let service = NetworkService()
        await #expect(throws: Error.self) {
            try await service.fetch([Transaction].self, from: "nonexistent_file")
        }
    }

    @Test("fetch successfully decodes the bundled transaction-list JSON file")
    func fetchDecodesTransactionListFromBundle() async throws {
        let service = NetworkService()
        let response = try await service.fetch(TransactionListResponse.self, from: "transaction-list")
        #expect(!response.transactions.isEmpty)
    }
}
