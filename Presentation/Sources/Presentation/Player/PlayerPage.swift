//
//  SwiftUIView.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils

public struct PlayerPage: View {
    @Binding var navigationManager: NavigationManager
    
    public init(navigationManager: Binding<NavigationManager>) {
        self._navigationManager = navigationManager
    }
    
    public var body: some View {
        VStack {
            Text("PlayerPage")
            Button("Go back") {
                navigationManager.pop()
            }
        }
    }
}

#Preview {
    PlayerPage(navigationManager: .constant(MockData.navManager))
}
