//
//  ConditionalGlassModifier.swift
//  Utils
//
//  Created by Александр Мельников on 31.01.2026.
//

import SwiftUI

public struct ConditionalGlassModifier: ViewModifier {
    
    public init() {}
    
    @ViewBuilder
    public func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.glassEffect()
        } else {
            content
        }
    }
}
