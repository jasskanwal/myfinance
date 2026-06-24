//
//  NetworkService.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

enum NetworkError: LocalizedError {
    case resourceNotFound(String)
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .resourceNotFound(let name):
            return "Resource '\(name).json' was not found in the app bundle."
        case .decodingFailed(let error):
            return "Failed to decode response: \(error.localizedDescription)"
        }
    }
}

// Network service fetches from local file
final class NetworkService: NetworkServiceProtocol {
    private let decoder = JSONDecoder()

    nonisolated func fetch<T: Decodable>(_ type: T.Type, from resource: String) async throws -> T {
        guard let url = Bundle.main.url(forResource: resource, withExtension: "json") else {
            throw NetworkError.resourceNotFound(resource)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw NetworkError.decodingFailed(error)
        }
    }
}
