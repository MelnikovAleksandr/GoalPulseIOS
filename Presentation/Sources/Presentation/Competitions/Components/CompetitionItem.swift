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
            .frame(width: 120, height: 120)
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                HStack {
                    Text(competition.name)
                        .font(.theme.italic(18))
                        .foregroundColor(Color.theme.secondary)
                    AsyncSVGImage(url: competition.area.flag) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 40, height: 40)
                }
                Text("Начало: \(competition.currentSeason.startDate)")
                Text("Окончание: \(competition.currentSeason.endDate)")
                Text("Текущий тур: \(competition.currentSeason.currentMatchDay)")
            }
            
            .padding(.leading, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}

#Preview {
    CompetitionItem(competition: MockUIData.competition)
        .loadCustomFonts()
}
