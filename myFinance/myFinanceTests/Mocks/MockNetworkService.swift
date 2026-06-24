//
//  MockNetworkService.swift
//  myFinanceTests
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation
@testable import myFinance

struct MockNetworkService: NetworkServiceProtocol {
    var mockResponse: TransactionListResponse
    var shouldThrow = false

    init(transactions: [Transaction] = [], shouldThrow: Bool = false) {
        self.mockResponse = TransactionListResponse(transactions: transactions)
        self.shouldThrow = shouldThrow
    }

    func fetch<T: Decodable>(_ type: T.Type, from resource: String) async throws -> T {
        if shouldThrow {
            throw NetworkError.resourceNotFound(resource)
        }
        if let result = mockResponse as? T {
            return result
        }
        throw NetworkError.resourceNotFound(resource)
    }
}
