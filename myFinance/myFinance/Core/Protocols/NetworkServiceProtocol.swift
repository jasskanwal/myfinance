//
//  NetworkServiceProtocol.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ type: T.Type, from resource: String) async throws -> T
}
