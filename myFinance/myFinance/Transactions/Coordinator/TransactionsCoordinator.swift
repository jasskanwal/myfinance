//
//  TransactionsCoordinator.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI
import Swinject

// MARK: - Route

enum TransactionRoute: AppRoute {
    case detail(TransactionDetailViewModel)

    @ViewBuilder
    var destination: some View {
        switch self {
        case .detail(let viewModel):
            TransactionDetailView(viewModel: viewModel)
        }
    }

    static func == (lhs: TransactionRoute, rhs: TransactionRoute) -> Bool {
        switch (lhs, rhs) {
        case (.detail(let l), .detail(let r)): return l === r
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .detail(let vm): hasher.combine(ObjectIdentifier(vm))
        }
    }
}

// MARK: - Coordinator

final class TransactionsCoordinator: Coordinator {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func start() -> AnyView {
        guard let viewModel = resolver.resolve(TransactionsViewModel.self) else {
            fatalError("TransactionsViewModel not registered in DI container")
        }
        viewModel.makeDetailViewModel = { [resolver] transaction in
            resolver.resolve(TransactionDetailViewModel.self, argument: transaction)!
        }
        viewModel.navigate = { [weak viewModel] route in
            viewModel?.navigationPath.append(route)
        }
        return AnyView(TransactionsView(viewModel: viewModel))
    }
}
