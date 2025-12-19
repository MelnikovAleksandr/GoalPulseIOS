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

public struct ThemeFonts: Sendable {
    
    public func regular(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Regular", size: size)
    }
    
    public func medium(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Medium", size: size)
    }
    
    public func semiBold(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-SemiBold", size: size)
    }
    
    public func bold(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Bold", size: size)
    }
    
    public func light(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Light", size: size)
    }
    
    public func thin(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Thin", size: size)
    }
    
    public func italic(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-Italic", size: size)
    }
    
    public func mediumItalic(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-MediumItalic", size: size)
    }
    
    public func semiBoldItalic(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-SemiBoldItalic", size: size)
    }
    
    public func lightItalic(_ size: CGFloat) -> Font {
        .custom("IBMPlexSans-LightItalic", size: size)
    }
}
