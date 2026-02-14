//
//  PullRefresh.swift
//  Utils
//
//  Created by Александр Мельников on 04.01.2026.
//

import SwiftUI

extension ScrollView {
    @MainActor public func refreshable<V>(
        isRefreshing: Binding<Bool>,
        action: @escaping () async -> Void,
        @ViewBuilder indicatorView: () -> V,
        refreshThreshold: CGFloat = 64.0,
        displayIndicatorThreshold: CGFloat = 0.6
    ) -> some View where V: View {
        self
            .modifier(RefreshableViewModifier(
                isRefreshing: isRefreshing,
                refreshThreshold: refreshThreshold,
                displayIndicatorThreshold: displayIndicatorThreshold,
                refreshAction: action,
                indicatorView: indicatorView()
            ))
    }
}

private struct RefreshableViewModifier<V>: ViewModifier where V: View {
    @Binding var isRefreshing: Bool
    var refreshThreshold: CGFloat = 64.0
    var displayIndicatorThreshold: CGFloat = 0.6
    var refreshAction: () async -> Void
    var indicatorView: V
    
    @State private var contentInsetDifference: CGFloat = 0.0
    @State private var indicatorViewDefaultHeight: CGFloat? = nil
    
    func body(content: Content) -> some View {
        ScrollView {
            VStack {
                let differenceThresholdFactor = contentInsetDifference / -refreshThreshold
                
                if differenceThresholdFactor > displayIndicatorThreshold || isRefreshing {
                    let scaleFactor = displayIndicatorThreshold >= 1 ? 1.0 :
                        (1.0 / (1.0 - displayIndicatorThreshold)) * differenceThresholdFactor +
                        (1.0 - 1.0 / (1.0 - displayIndicatorThreshold))
                    
                    indicatorView
                        .overlay(
                            GeometryReader { geometry in
                                if self.indicatorViewDefaultHeight != geometry.size.height {
                                    DispatchQueue.main.async {
                                        self.indicatorViewDefaultHeight = geometry.size.height
                                    }
                                }
                                return Color.clear
                            }
                        )
                        .scaleEffect(!isRefreshing ? min(scaleFactor, 1.0) : 1.0)
                        .frame(height: (!isRefreshing && indicatorViewDefaultHeight != nil) ?
                               min(scaleFactor, 1.0) * indicatorViewDefaultHeight! : nil)
                        .transition(.asymmetric(insertion: .identity, removal: .scale.combined(with: .opacity)))
                }
                
                content
            }
            .scrollTargetLayout()
        }
        .onScrollGeometryChange(for: CGFloat.self) { geometry in
            return geometry.contentOffset.y + geometry.contentInsets.top
        } action: { _, new in
            self.contentInsetDifference = new
        }
        .onScrollPhaseChange { old, new, context in
            guard old == .interacting, new != .interacting else {
                return
            }
            
            let geometry = context.geometry
            if geometry.contentOffset.y + geometry.contentInsets.top < -refreshThreshold {
                self.isRefreshing = true
            }
        }
        .onChange(of: self.isRefreshing) {
            guard self.isRefreshing else { return }
            Task {
                await refreshAction()
                self.isRefreshing = false
            }
        }
        .animation(.default, value: self.isRefreshing)
    }
}
