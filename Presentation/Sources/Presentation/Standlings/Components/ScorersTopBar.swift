//
//  ScorersTopBar.swift
//  Presentation
//
//  Created by Александр Мельников on 17.01.2026.
//

import SwiftUI
import Domain
import Utils

struct ScorersTopBar: View {
    var body: some View {
        HStack(spacing: 0) {
            Text("№")
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing, .leading]).foregroundColor(Color.theme.primary))
            HStack(spacing: 0) {
                Text(Locale.get("Player"))
                    .padding(.horizontal, 10)
                    .font(.theme.semiBold(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
            }
            .frame(height: 32)
            .containerRelativeFrame(.horizontal, count: 10, span: 5, spacing: 0)
            .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            
            Text(Locale.get("G"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("A"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("Pen"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
                .background(Color.gray)
                .overlay(EdgeBorder(width: 1, edges: [.top, .trailing]).foregroundColor(Color.theme.primary))
            Text(Locale.get("M"))
                .font(.theme.semiBold(17))
                .foregroundColor(Color.theme.onBackground)
                .frame(height: 32)
                .lineLimit(1)
                .containerRelativeFrame(.horizontal, count: 10, span: 1, spacing: 0)
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
    Group {
        ScorersTopBar().loadCustomFonts()
    }.background(Color.theme.background)
}
