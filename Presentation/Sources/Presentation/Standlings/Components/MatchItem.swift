//
//  MatchItem.swift
//  Presentation
//
//  Created by Александр Мельников on 29.01.2026.
//

import SwiftUI
import Domain
import Utils

struct MatchItem: View {
    let match: Match
    let isAhead: Bool
    var body: some View {
        VStack(spacing: 0) {
            Spacer().frame(height: 12)
            HStack(spacing: 0) {
                AsyncMultiImage(url: match.homeTeam.crest).frame(width: 32, height: 32)
                Spacer().frame(width: 16)
                if isAhead {
                    Text(UIDateTimeFormatters.dayMonthFormatter.string(from: match.dateTime))
                        .foregroundColor(Color.theme.onBackground)
                        .font(.theme.medium(24))
                        .padding(10)
                } else {
                    ScoreItem(homeScore: match.score.time.home, awayScore: match.score.time.away)
                }
                Spacer().frame(width: 16)
                AsyncMultiImage(url: match.awayTeam.crest).frame(width: 32, height: 32)
            }
            
            HStack(spacing: 0) {
                Text(match.homeTeam.name)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(Color.theme.onBackground)
                    .font(.theme.medium(18))
                
                Text(" - ")
                    .padding(.horizontal, 4)
                
                Text(match.awayTeam.name)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(Color.theme.onBackground)
                    .font(.theme.medium(18))
            }
            
            HStack(spacing: 0) {
                Text(match.dateTime, style: .date)
                    .lineLimit(1)
                    .foregroundColor(Color.theme.secondary)
                    .font(.theme.medium(15))
                Text(", ")
                Text(match.dateTime, style: .time)
                    .lineLimit(1)
                    .foregroundColor(Color.theme.secondary)
                    .font(.theme.medium(15))
            }
            Spacer().frame(height: 12)
            Divider().background(Color.theme.primary)
            
        }
    }
}

#Preview {
    MatchItem(match: MockUIData.getMatchesByTour().first!.matches.first!, isAhead: true).loadCustomFonts()
    MatchItem(match: MockUIData.getMatchesByTour().first!.matches.first!, isAhead: false).loadCustomFonts()
}
