//
//  AppCoordinator.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI
import Swinject

final class AppCoordinator: Coordinator {
    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func start() -> AnyView {
        guard let coordinator = resolver.resolve(TransactionsCoordinator.self) else {
            fatalError("TransactionsCoordinator not registered in DI container")
        }
        return coordinator.start()
    }
}
