//
//  ScoreItem.swift
//  Presentation
//
//  Created by Александр Мельников on 29.01.2026.
//

import SwiftUI
import Domain

struct ScoreItem: View {
    let match: Match
    let teamId: Int?
    let isHomeTeam: Bool
    let isAwayTeam: Bool
    let color: Color
    
    init(match: Match, teamId: Int? = nil) {
        self.match = match
        self.teamId = teamId
        isHomeTeam = teamId == match.homeTeam.id
        isAwayTeam = teamId == match.awayTeam.id
        
        guard teamId != nil else {
            self.color = Color.theme.primary
            return
        }
        
        switch match.score.winner {
        case .home:
            self.color = isHomeTeam ?
            Color.theme.primary :
            Color.theme.error.opacity(0.7)
            
        case .away:
            self.color = isAwayTeam ?
            Color.theme.primary :
            Color.theme.error.opacity(0.7)
            
        default:
            self.color = Color.theme.secondary.opacity(0.7)
        }
    }
    
    
    
    var body: some View {
        Text("\(match.score.time.home) - \(match.score.time.away)")
            .foregroundColor(Color.theme.onBackground)
            .font(.theme.regular(22))
            .padding(10)
            .background(color)
            .cornerRadius(8)
    }
}

#Preview {
    VStack {
        ScoreItem(match: MockUIData.getMatchesByTour().first!.matches.first!)
        ScoreItem(match: MockUIData.getMatchesByTour().first!.matches.first!, teamId: 1920)
        ScoreItem(match: MockUIData.getMatchesByTour()[1].matches.first!, teamId: 1915)
        ScoreItem(match: MockUIData.getMatchesByTour()[1].matches.first!, teamId: 670)
    }
}


