//
//  TabView.swift
//  Presentation
//
//  Created by Александр Мельников on 06.01.2026.
//

import SwiftUI
import Utils

enum Tab: String, CaseIterable, Hashable {
    
    case standings = "Standings"
    case players = "Players"
    case matches = "Matches"
    
    var localizedTitle: String {
        Locale.get(rawValue)
    }
    
}
