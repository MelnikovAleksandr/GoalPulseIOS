//
//  Header.swift
//  Presentation
//
//  Created by Александр Мельников on 24.12.2025.
//

import SwiftUI
import Utils

struct Header: View {
    
    let scrollOffset: CGFloat
    
    var body: some View {
        HStack {
            Text(Locale.get("AppName"))
                .lineLimit(1)
                .font(.system(
                    size: max(15, 30 - scrollOffset / 10),
                    weight: .bold
                ))
                .foregroundColor(Color.theme.primary)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                .animation(.spring(response: 0.3), value: scrollOffset)
        }
        .opacity(Double(max(0, 1 - scrollOffset / 100)))
        .background(
            VisualEffectView(style: .systemUltraThinMaterial)
                .opacity(Double(max(0, 0.9 - scrollOffset / 100)))
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 12,
                        bottomLeadingRadius: 12,
                        bottomTrailingRadius: 12,
                        topTrailingRadius: 12
                    )
                )
        )
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}

struct VisualEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
