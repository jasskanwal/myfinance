//
//  TransactionServiceProtocol.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

protocol TransactionServiceProtocol {
    func fetchTransactions() async throws -> [Transaction]
}
