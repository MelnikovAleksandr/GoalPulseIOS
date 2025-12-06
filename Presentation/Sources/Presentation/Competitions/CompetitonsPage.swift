//
//  SwiftUIView.swift
//  Presentation
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Utils

public struct CompetitonsPage: View {
    @Binding var navigationManager: NavigationManager
    
    public init(navigationManager: Binding<NavigationManager>) {
        self._navigationManager = navigationManager
    }
    
    public var body: some View {
        VStack {
            Text("CompetitonsPage")
            Button("Go to Standlings") {
                navigationManager.toStandlings()
            }
        }
    }
}

#Preview {
    CompetitonsPage(
        navigationManager: .constant(MockData.navManager)
    )
}
