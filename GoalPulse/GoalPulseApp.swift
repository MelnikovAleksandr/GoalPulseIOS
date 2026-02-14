//
//  GoalPulseApp.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import SwiftUI
import Utils
import Presentation
import Data

@main
struct GoalPulseApp: App {
    init() {
        SVGHelper.setUpDependencies()
        FontsHelper.registerFonts()
        ResolverApp.injectUtils()
        ResolverApp.injectDataSources()
        ResolverApp.injectViewModels()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
