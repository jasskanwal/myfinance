//
//  TransactionsView.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

struct TransactionsView: View {
    @ObservedObject var viewModel: TransactionsViewModel

    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            // TODO: pull to refresh
        Group {
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading transactions...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                case .error(let message):
                    errorView(message: message)
                case .loaded:
                    transactionList
                }
            }
            .navigationTitle(viewModel.navigationTitle)
            .task {
                await viewModel.loadTransactions()
            }
            .navigationDestination(for: TransactionRoute.self)
        }
    }

    private var transactionList: some View {
        List(viewModel.transactions) { transaction in
            Button {
                viewModel.selectTransaction(transaction)
            } label: {
                TransactionRowView(transaction: transaction)
            }
            .buttonStyle(.plain)
            .accessibilityIdentifier("transaction-\(transaction.id)")
        }
        .listStyle(.plain)
        .accessibilityIdentifier("transactionList")
    }

    private func errorView(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(AppFonts.errorIcon)
                .foregroundStyle(AppColors.error)
            Text("Something went wrong")
                .font(AppFonts.errorTitle)
            Text(message)
                .font(AppFonts.errorBody)
                .foregroundStyle(AppColors.secondaryText)
                .multilineTextAlignment(.center)
            Button("Try Again") {
                Task { await viewModel.loadTransactions() }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
