//
//  TabView.swift
//  Presentation
//
//  Created by Александр Мельников on 06.02.2026.
//
import SwiftUI
import Utils

enum TabTeam: String, CaseIterable, Hashable {
    
    case team = "Team"
    case info = "Info"
    case matches = "Matches"
    case ahead = "Ahead"
    
    var localizedTitle: String {
        Locale.get(rawValue)
    }
    var systemImageName: String {
            switch self {
            case .team:
                return "person.3.fill"
            case .info:
                return "info.circle.fill"
            case .matches:
                return "sportscourt.fill"
            case .ahead:
                return "clock.badge"
            }
        }
}
