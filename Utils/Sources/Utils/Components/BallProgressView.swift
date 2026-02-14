//
//  BallProgressView.swift
//  Utils
//
//  Created by Александр Мельников on 04.01.2026.
//

import SwiftUI

public struct BallProgressView: View {
    @State private var animate = false
    private var width: CGFloat
    private var height: CGFloat
    public init(width: CGFloat=100, height: CGFloat=100) {
        self.width = width
        self.height = height
    }
    public var body: some View {
        Image(systemName: "soccerball")
            .resizable()
            .frame(width: width, height: height)
            .rotationEffect(Angle(degrees: animate ? 370 : 0))
            .animation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false),
                value: animate
            )
            .foregroundColor(Color.theme.primary)
            .onAppear {
                withAnimation {
                    animate.toggle()
                }
            }
    }
}

#Preview {
    BallProgressView()
}
