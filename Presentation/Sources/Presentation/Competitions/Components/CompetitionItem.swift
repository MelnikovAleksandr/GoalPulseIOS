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
            AsyncImage(url: competition.emblem) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Image(systemName: "photo")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 100, height: 100)
            .padding(8)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Text(competition.name)
                        .lineLimit(1)
                        .font(.theme.semiBoldItalic(18))
                        .foregroundColor(Color.theme.onBackground)
                    AsyncSVGImage(url: competition.area.flag) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 24, height: 24)
                }
                Text("Start: \(competition.currentSeason.startDate)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
                Text("End: \(competition.currentSeason.endDate)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
                Text("Current tour: \(competition.currentSeason.currentMatchDay)")
                    .lineLimit(1)
                    .font(.theme.medium(14))
                    .foregroundColor(Color.theme.secondary)
            }.padding(.horizontal, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.theme.background)
        )
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    CompetitionItem(competition: MockUIData.competition)
        .loadCustomFonts()
}
