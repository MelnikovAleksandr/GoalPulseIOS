//
//  GoalPulseApp.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Utils

@main
struct GoalPulseApp: App {
    init() {
        Resolver.shared.injectModules()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
