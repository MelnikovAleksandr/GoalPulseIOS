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
    case ahead = "Ahead"
    
    var localizedTitle: String {
        Locale.get(rawValue)
    }
    var systemImageName: String {
            switch self {
            case .standings:
                return "tablecells.fill"
            case .players:
                return "person.2.fill"
            case .matches:
                return "sportscourt.fill"
            case .ahead:
                return "clock.badge"
            }
        }
}
