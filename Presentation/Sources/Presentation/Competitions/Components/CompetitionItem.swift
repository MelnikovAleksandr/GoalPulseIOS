//
//  CompetitionItem.swift
//  Presentation
//
//  Created by Александр Мельников on 19.12.2025.
//

import SwiftUI
import Domain
import Utils

struct CompetitionItem: View {
    let competition: Competition
    
    var body: some View {
        HStack {
            AsyncMultiImage(url: competition.emblem).frame(width: 100, height: 100).padding(8)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Text(competition.name)
                        .lineLimit(1)
                        .font(.theme.semiBoldItalic(18))
                        .foregroundColor(Color.theme.onBackground)
                    
                    AsyncMultiImage(url: competition.area.flag).frame(width: 24, height: 24)
                    
                }
                Text("\(Locale.get("Start")) \(competition.currentSeason.startDate)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
                Text("\(Locale.get("End")) \(competition.currentSeason.endDate)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
                Text("\(Locale.get("CurrentTour")) \(competition.currentSeason.currentMatchDay)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
            }.padding(.horizontal, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.background)
                .opacity(0.8)
        )
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    SVGHelper.setUpDependencies()
    return CompetitionItem(competition: MockUIData.competition)
        .loadCustomFonts()
}
