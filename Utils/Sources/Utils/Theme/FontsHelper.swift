//
//  FontsHelper.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//
import SwiftUI

public struct FontsHelper {
    public static func registerFonts() {
        FontsEnum.allCases.forEach {
            guard let fontURL = Bundle.module.url(forResource: $0.rawValue, withExtension: "ttf") else { return }
            var error: Unmanaged<CFError>?
            CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        }
    }
}

// For preview
extension View {
    public func loadCustomFonts() -> some View {
        FontsHelper.registerFonts()
        return self
    }
}
