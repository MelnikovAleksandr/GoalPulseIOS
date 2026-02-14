//
//  SquadHeader.swift
//  Presentation
//
//  Created by Александр Мельников on 07.02.2026.
//

import SwiftUI
import Domain
import Utils

struct SquadHeader: View {
    
    let position: PlayerPosition
    let color: Color
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(position.localizedTitle)
                    .padding(.vertical, 4)
                    .padding(.leading, 8)
                    .font(.theme.semiBoldItalic(18))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
            }
            Divider()
                .background(Color.theme.primary)
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(Locale.get("Name"))
                        .padding(.vertical, 4)
                        .font(.theme.medium(17))
                        .foregroundColor(Color.theme.secondary)
                        .lineLimit(1)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 2, spacing: 8)
                
                HStack(spacing: 0) {
                    Text(Locale.get("Nation"))
                        .font(.theme.medium(17))
                        .foregroundColor(Color.theme.secondary)
                        .lineLimit(1)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 8)
                
                HStack(spacing: 0) {
                    Text(Locale.get("Age"))
                        .font(.theme.medium(17))
                        .foregroundColor(Color.theme.secondary)
                        .lineLimit(1)
                        .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 0)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 8)
                
                
            }
        }
        .frame(maxWidth: .infinity)
        .background(color.contrast(0.4))
    }
}

#Preview {
    SquadHeader(position: PlayerPosition.attackingMidfield, color: Color.theme.primaryContainer).loadCustomFonts()
}
