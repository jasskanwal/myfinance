//
//  TransactionDetailViewModel.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

@MainActor
final class TransactionDetailViewModel {

    // MARK: - Detail Row

    enum DetailRow: Identifiable {
        case from(account: String, cardSuffix: String)
        case amount(String)

        var id: String {
            switch self {
            case .from:   return "from"
            case .amount: return "amount"
            }
        }

        var label: String {
            switch self {
            case .from:   return "From"
            case .amount: return "Amount"
            }
        }

        var value: String {
            switch self {
            case .from(let account, _): return account
            case .amount(let v):        return v
            }
        }

        var secondaryValue: String? {
            switch self {
            case .from(_, let suffix): return "(\(suffix))"
            case .amount:              return nil
            }
        }
    }

    // MARK: - Detail Section

    enum DetailSection: Identifiable {
        case header(isCredit: Bool, title: String)
        case transactionDetail([DetailRow])
        case notice

        var id: String {
            switch self {
            case .header:            return "header"
            case .transactionDetail: return "transactionDetail"
            case .notice:            return "notice"
            }
        }
    }

    // MARK: - Properties

    let transaction: Transaction
    private let currencyFormatter: CurrencyFormatterProtocol

    init(transaction: Transaction, currencyFormatter: CurrencyFormatterProtocol) {
        self.transaction = transaction
        self.currencyFormatter = currencyFormatter
    }

    var isCredit: Bool { transaction.transactionType == .credit }

    var title: String {
        isCredit ? "Credit transaction" : "Debit transaction"
    }

    // MARK: - Strings

    let navigationTitle = "Transaction Detail"
    let closeButtonTitle = "Close"
    let noticeBaseText = "Transactions are processed Monday to Friday (excluding holidays). "
    let noticeExpandedText = "Transactions made before 8:30pm ET Monday to Friday (excluding holidays) will show up in your account same day. "
    let noticeShowMoreLabel = "Show more"
    let noticeShowLessLabel = "Show less"

    // MARK: - Sections

    var sections: [DetailSection] {
        [
            .header(isCredit: isCredit, title: title),
            .transactionDetail(rows),
            .notice
        ]
    }

    // MARK: - Rows

    private var rows: [DetailRow] {
        [
            .from(account: transaction.fromAccount, cardSuffix: String(transaction.fromCardNumber.suffix(4))),
            .amount(currencyFormatter.string(from: transaction.amount)),
        ]
    }
}
