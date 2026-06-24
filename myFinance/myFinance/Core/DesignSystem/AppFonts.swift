//
//  AppFonts.swift
//  myFinance
//
//  Created by Jaskirat Singh on 2026-06-22
//

import SwiftUI

enum AppFonts {
    // Transaction row
    static let merchantName = Font.subheadline.weight(.medium)
    static let merchantDescription = Font.caption
    static let amount = Font.subheadline

    // Detail screen
    static let detailTitle = Font.title3
    static let detailLabel = Font.caption
    static let detailValue = Font.subheadline
    static let closeButton = Font.body.weight(.semibold)
    static let headerIcon  = Font.system(size: 22, weight: .medium)

    // Error state
    static let errorIcon = Font.system(size: 48)
    static let errorTitle = Font.headline
    static let errorBody = Font.subheadline
}
