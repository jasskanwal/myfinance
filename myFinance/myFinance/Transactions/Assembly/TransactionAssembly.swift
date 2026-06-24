//
//  TransactionAssembly.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Swinject

final class TransactionAssembly: Assembly {
    private let viewAssembly = TransactionViewAssembly()

    func assemble(container: Container) {
        // MARK: Service
        container.register(TransactionServiceProtocol.self) { resolver in
            guard let networkService = resolver.resolve(NetworkServiceProtocol.self) else {
                fatalError("NetworkServiceProtocol not registered")
            }
            return TransactionService(networkService: networkService)
        }.inObjectScope(.container)

        // MARK: View layer
        viewAssembly.assemble(container: container)

        // MARK: Coordinator
        container.register(TransactionsCoordinator.self) { resolver in
            TransactionsCoordinator(resolver: resolver)
        }.inObjectScope(.transient)
    }
}
