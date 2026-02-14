//
//  StandingItem.swift
//  Presentation
//
//  Created by Александр Мельников on 30.12.2025.
//

import SwiftUI
import Domain
import Utils

struct StandingItem: View {
    
    let table: Domain.Table
    let standingLastId: Int?
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(table.position)")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing, .leading]).foregroundColor(Color.theme.primary))
            HStack(spacing: 0) {
                AsyncMultiImage(url: table.team?.crest)
                    .frame(width: 24, height: 24)
                    .padding(.horizontal, 10)
                Text("\(table.team?.name ?? "")")
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
            }
            .frame(height: 32)
            .containerRelativeFrame(.horizontal, count: 14, span: 6, spacing: 0)
            .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            
            Text("\(table.playedGames)")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.won)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.draw)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.lost)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.goalsFor)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.goalsAgainst)")
                .font(.theme.regular(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text("\(table.points)")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
        }
        .overlay(alignment: .bottom) {
            if standingLastId == table.id {
                Rectangle()
                    .fill(Color.theme.primary)
                    .frame(height: 1)
            }
        }
    }
}

struct EdgeBorder: Shape {
    let width: CGFloat
    let edges: [Edge]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        for edge in edges {
            switch edge {
            case .top:
                path.addRect(CGRect(x: 0, y: 0, width: rect.width, height: width))
            case .trailing:
                path.addRect(CGRect(x: rect.width - width, y: 0, width: width, height: rect.height))
            case .bottom:
                path.addRect(CGRect(x: 0, y: rect.height - width, width: rect.width, height: width))
            case .leading:
                path.addRect(CGRect(x: 0, y: 0, width: width, height: rect.height))
            }
        }
        
        return path
    }
}

#Preview {
    
    let table = MockUIData.standings.standings.first?.table.first
    Group {
        StandingItem(table: table!, standingLastId: 674).loadCustomFonts()
    }.background(Color.theme.background)

}
