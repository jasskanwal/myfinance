//
//  AppColors.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

enum AppColors {
    // Transaction amounts
    static let credit = Color.green
    static let creditBadgeBackground = Color.green.opacity(0.12)

    // Text
    static let primaryText = Color.primary
    static let secondaryText = Color.secondary

    // Detail screen
    static let listBackground = Color(.systemBackground)
    static let accent = Color(red: 231.0/255.0, green: 14.0/255.0, blue: 30.0/255.0)
	static let systemGroupedBackground = Color(.systemGroupedBackground)
	static let seperator = Color(.separator)

    // Interactive
    static let link = Color.blue
    static let buttonForeground = Color.white

    // Feedback
    static let error = Color.red
}
