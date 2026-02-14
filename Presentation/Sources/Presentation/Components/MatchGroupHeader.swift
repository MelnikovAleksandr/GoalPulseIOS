//
//  MatchGroupHeader.swift
//  Presentation
//
//  Created by Александр Мельников on 30.01.2026.
//

import SwiftUI
import Domain
import Utils

struct MatchGroupHeader: View {
    let matchesByTour: MatchesByTour
    
    var body: some View {
        HStack {
            Text(headerText)
                .foregroundColor(Color.theme.onSecondary)
                .font(.theme.medium(18))
                .padding(.leading, 8)
                .padding(.vertical, 8)
                .lineLimit(1)
                .truncationMode(.tail)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.secondary)
    }
    // TODO string res
    private var headerText: String {
        if matchesByTour.matchday == -1 {
            return matchesByTour.stage
        } else if matchesByTour.seasonType == "CUP" {
            return "\(matchesByTour.matchday) tour \(matchesByTour.stage)"
        } else {
            return "\(matchesByTour.matchday) tour"
        }
    }
}

#Preview {
    MatchGroupHeader(matchesByTour: MockUIData.getMatchesByTour().first!).loadCustomFonts()
}
