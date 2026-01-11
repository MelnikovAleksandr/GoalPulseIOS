//
//  ScrollUtils.swift
//  Presentation
//
//  Created by Александр Мельников on 11.01.2026.
//
import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 0
    
    func body(content: Content) -> some View {
        content.overlay {
            GeometryReader { proxy in
                
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
                    .onPreferenceChange(OffsetKey.self) { value in
                        if startValue == 0 {
                            startValue = value
                        }
                        
                        offset = (value - (returnFromStart ? startValue: 0))
                    }
                
            }
        }
    }
    
}

struct OffsetKey: @preconcurrency PreferenceKey {
    @MainActor static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetX(completion: @escaping (CGFloat) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                    
                    Color.clear
                        .preference(key: OffsetKey.self, value: minX)
                        .onPreferenceChange(OffsetKey.self, perform: completion)
                }
            }
    }
}
