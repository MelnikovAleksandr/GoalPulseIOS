//
//  SwiftUIView.swift
//  Presentation
//
//  Created by Александр Мельников on 07.12.2025.
//

import SwiftUI
import Utils

public struct StandlingsPage: View {
    @Binding var navigationManager: NavigationManager
    
    public init(navigationManager: Binding<NavigationManager>) {
        self._navigationManager = navigationManager
    }
    
    public var body: some View {
        VStack {
            Text("StandlingsPage")
            Button("Go to Team") {
                navigationManager.toTeamDetails()
            }
            Button("Go to Player") {
                navigationManager.toPlayerDetails()
            }
            Button("Go back") {
                navigationManager.pop()
            }
        }
    }
}

#Preview {
    StandlingsPage(navigationManager: .constant(MockData.navManager))
}
