//
//  myFinanceApp.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

@main
struct myFinanceApp: App {
    private let coordinator: AppCoordinator

    init() {
        let appContainer = AppContainer()
        coordinator = AppCoordinator(resolver: appContainer.resolver)
    }

    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
