//
//  Fonts.swift
//  Utils
//
//  Created by Александр Мельников on 19.12.2025.
//

import SwiftUI

extension Font {
    public static let theme = ThemeFonts()
}

public enum FontsEnum: String, CaseIterable {
    case Regular = "IBMPlexSans-Regular"
    case Medium = "IBMPlexSans-Medium"
    case SemiBold = "IBMPlexSans-SemiBold"
    case Bold = "IBMPlexSans-Bold"
    case Light = "IBMPlexSans-Light"
    case Thin = "IBMPlexSans-Thin"
    case Italic = "IBMPlexSans-Italic"
    case MediumItalic = "IBMPlexSans-MediumItalic"
    case SemiBoldItalic = "IBMPlexSans-SemiBoldItalic"
    case LightItalic = "IBMPlexSans-LightItalic"
}

public struct ThemeFonts: Sendable {
    
    public func regular(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Regular.rawValue, size: size)
    }
    
    public func medium(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Medium.rawValue, size: size)
    }
    
    public func semiBold(_ size: CGFloat) -> Font {
        .custom(FontsEnum.SemiBold.rawValue, size: size)
    }
    
    public func bold(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Bold.rawValue, size: size)
    }
    
    public func light(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Light.rawValue, size: size)
    }
    
    public func thin(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Thin.rawValue, size: size)
    }
    
    public func italic(_ size: CGFloat) -> Font {
        .custom(FontsEnum.Italic.rawValue, size: size)
    }
    
    public func mediumItalic(_ size: CGFloat) -> Font {
        .custom(FontsEnum.MediumItalic.rawValue, size: size)
    }
    
    public func semiBoldItalic(_ size: CGFloat) -> Font {
        .custom(FontsEnum.SemiBoldItalic.rawValue, size: size)
    }
    
    public func lightItalic(_ size: CGFloat) -> Font {
        .custom(FontsEnum.LightItalic.rawValue, size: size)
    }
}
