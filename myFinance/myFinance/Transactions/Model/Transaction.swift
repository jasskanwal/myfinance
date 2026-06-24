//
//  Transaction.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

enum TransactionType: String, Codable, Hashable {
    case debit  = "DEBIT"
    case credit = "CREDIT"
}

struct TransactionAmount: Codable, Equatable, Hashable {
    let value: Double
    let currency: String
}

struct Transaction: Identifiable, Codable, Hashable {
    let key: String
    let transactionType: TransactionType
    let merchantName: String
    let description: String?
    let amount: TransactionAmount
    let postedDate: String
    let fromAccount: String
    let fromCardNumber: String

    var id: String { key }

    var formattedDate: String {
        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd"
        let output = DateFormatter()
        output.dateStyle = .medium
        return input.date(from: postedDate).map { output.string(from: $0) } ?? postedDate
    }

    static func == (lhs: Transaction, rhs: Transaction) -> Bool { lhs.key == rhs.key }
    func hash(into hasher: inout Hasher) { hasher.combine(key) }

    enum CodingKeys: String, CodingKey {
        case key
        case transactionType  = "transaction_type"
        case merchantName     = "merchant_name"
        case description
        case amount
        case postedDate       = "posted_date"
        case fromAccount      = "from_account"
        case fromCardNumber   = "from_card_number"
    }
}

struct TransactionListResponse: Codable {
    let transactions: [Transaction]
}
