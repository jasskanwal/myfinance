//
//  NetworkAssembly.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Swinject

final class NetworkAssembly: Assembly {
    func assemble(container: Container) {
        container.register(NetworkServiceProtocol.self) { _ in
            NetworkService()
        }.inObjectScope(.container)
    }
}
