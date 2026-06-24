//
//  TransactionViewAssembly.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Swinject

final class TransactionViewAssembly: Assembly {
    func assemble(container: Container) {
        container.register(CurrencyFormatterProtocol.self) { _ in
            CurrencyFormatter()
        }.inObjectScope(.container)

        container.register(TransactionDetailViewModel.self) { (resolver, transaction: Transaction) in
            guard let formatter = resolver.resolve(CurrencyFormatterProtocol.self) else {
                fatalError("CurrencyFormatterProtocol not registered in DI container")
            }
            return TransactionDetailViewModel(transaction: transaction, currencyFormatter: formatter)
        }

        container.register(TransactionsViewModel.self) { resolver in
            guard let service = resolver.resolve(TransactionServiceProtocol.self) else {
                fatalError("TransactionServiceProtocol not registered in DI container")
            }
            return TransactionsViewModel(transactionService: service)
        }.inObjectScope(.container)
    }
}
