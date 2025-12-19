//
//  Colors.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//

import SwiftUI

extension Color {
    public static let theme = ThemeColors()
}

public struct ThemeColors : Sendable {
    
    public let background = Color(.onPrimary)
    public let surface = Color(.surface)
    public let primary = Color(.primary)
    public let primaryContainer = Color(.primaryContainer)
    public let secondary = Color(.secondary)
    public let onBackground = Color(.onBackground)
    public let onSurface = Color(.onSurface)
    public let onPrimary = Color(.onPrimary)
    public let onPrimaryContainer = Color(.onPrimaryContainer)
    public let onSecondary = Color(.onSecondary)
    public let error = Color(.error)
}
