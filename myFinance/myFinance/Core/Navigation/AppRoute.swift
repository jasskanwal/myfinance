//
//  AppRoute.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

protocol AppRoute: Hashable {
    associatedtype Destination: View
    @ViewBuilder var destination: Destination { get }
}

extension View {
    func navigationDestination<R: AppRoute>(for routeType: R.Type) -> some View {
        navigationDestination(for: routeType) { route in
            route.destination
        }
    }
}
