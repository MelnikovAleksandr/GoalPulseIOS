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
    
    public let background = Color("Background")
    public let surface = Color("Surface")
    public let primary = Color("Primary")
    public let primaryContainer = Color("PrimaryContainer")
    public let secondary = Color("Secondary")
    public let onBackground = Color("OnBackground")
    public let onSurface = Color("OnSurface")
    public let onPrimary = Color("OnPrimary")
    public let onPrimaryContainer = Color("OnPrimaryContainer")
    public let onSecondary = Color("OnSecondary")
    public let error = Color("Error")
}
