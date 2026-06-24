//
//  TransactionRowView.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction

    private var isCredit: Bool { transaction.transactionType == .credit }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.merchantName)
                    .font(AppFonts.merchantName)
                    .foregroundStyle(AppColors.primaryText)
                if let description = transaction.description {
                    Text(description)
                        .font(AppFonts.merchantDescription)
                        .foregroundStyle(AppColors.secondaryText)
                        .lineLimit(1)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            Text("\(isCredit ? "+" : "-") \(transaction.amount.currency) \(transaction.amount.value, specifier: "%.2f")")
                .font(AppFonts.amount)
                .foregroundStyle(isCredit ? AppColors.credit : AppColors.primaryText)
                .padding(.horizontal, isCredit ? 8 : 0)
                .padding(.vertical, isCredit ? 4 : 0)
                .background(isCredit ? AppColors.creditBadgeBackground : Color.clear, in: Capsule())
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(transaction.merchantName), \(isCredit ? "credit" : "debit"), \(transaction.amount.currency) \(String(format: "%.2f", transaction.amount.value))")
    }
}
