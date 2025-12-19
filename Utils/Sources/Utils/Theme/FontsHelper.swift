//
//  FontsHelper.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//
import SwiftUI

public struct FontsHelper {
    public static func resigterFonts() {
        FontsEnum.allCases.forEach {
            registerFont(bundle: Bundle.module, fontName: $0.rawValue, fontExtension: "ttf")
        }
    }
    
    
    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
            fatalError("Cant create font from filename: \(fontName) with ext \(fontExtension)")
        }
        var error : Unmanaged<CFError>?
        CTFontManagerRegisterGraphicsFont(font, &error)
    }
}

// For preview
extension View {
    public func loadCustomFonts() -> some View {
        FontsHelper.resigterFonts()
        return self
    }
}
