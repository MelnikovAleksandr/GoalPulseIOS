//
//  ScorerItem.swift
//  Presentation
//
//  Created by Александр Мельников on 17.01.2026.
//

import SwiftUI
import Domain
import Utils

struct ScorerItem: View {
    let scorer: Scorer
    let scorersLastId: Int?
    let scorerIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(scorerIndex)")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing, .leading]).foregroundColor(Color.theme.primary))
            HStack(spacing: 0) {
                AsyncMultiImage(url: scorer.team.crest)
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 10)
                VStack(alignment: .leading, spacing: 0) {
                    Text("\(scorer.player.name)")
                        .font(.theme.medium(13))
                        .foregroundColor(Color.theme.onBackground)
                        .lineLimit(1)
                    Text("\(scorer.team.name)")
                        .font(.theme.italic(11))
                        .foregroundColor(Color.theme.onPrimaryContainer)
                        .lineLimit(1)
                }
                Spacer()
            }
            .frame(height: 32)
            .containerRelativeFrame(.horizontal, count: 10, span: 5, spacing: 0)
            .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            
            Text("\(scorer.goals)")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(scorer.assists)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(scorer.penalties)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(scorer.playedMatches)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
        }
        .overlay(alignment: .bottom) {
            if scorersLastId == scorer.id {
                Rectangle()
                    .fill(Color.theme.primary)
                    .frame(height: 1)
            }
        }
    }
}

#Preview {
    let scorer = MockUIData.scorers().scorers.first!
    Group {
        ScorerItem(scorer: scorer, scorersLastId: 119460, scorerIndex: 2).loadCustomFonts()
    }.background(Color.theme.background)
}
