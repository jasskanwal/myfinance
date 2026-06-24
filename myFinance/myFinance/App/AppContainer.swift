//
//  AppContainer.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Swinject

final class AppContainer {
    private let assembler: Assembler

    var resolver: Resolver { assembler.resolver }

    init() {
        assembler = Assembler([
            NetworkAssembly(),
            TransactionAssembly(),
        ])
    }
}
