//
//  TableLeagueTopBar.swift
//  Presentation
//
//  Created by Александр Мельников on 30.12.2025.
//

import SwiftUI
import Domain
import Utils

struct TableLeagueTopBar: View {
    let standing: Standing
    let type: Type
    private var groupName: String {
        switch type {
        case Type.LEAGUE: Locale.get("Team")
        case Type.CUP: standing.group
        }
    }
    var body: some View {
        HStack(spacing: 0) {
            Text("№")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing, .leading]).foregroundColor(Color.theme.primary))
            HStack(spacing: 0) {
                Text(groupName)
                    .padding(.horizontal, 10)
                    .font(.theme.semiBold(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
            }
            .frame(height: 32)
            .containerRelativeFrame(.horizontal, count: 14, span: 6, spacing: 0)
            .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            
            Text(Locale.get("M"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("W"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("D"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("L"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("GF"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("GA"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("P"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 14, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
        }
        .background(Color.theme.background)
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.theme.primary)
                .frame(height: 1)
        }
    }
}

#Preview {
    TableLeagueTopBar(standing: MockUIData.standings.standings.first!, type: Type.CUP).loadCustomFonts()
}
