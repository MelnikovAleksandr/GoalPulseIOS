//
//  SquadItem.swift
//  Presentation
//
//  Created by Александр Мельников on 07.02.2026.
//

import SwiftUI
import Domain
import Utils

struct SquadItem: View {
    
    let player: Person
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text(player.name)
                        .padding(.vertical, 8)
                        .font(.theme.regular(17))
                        .foregroundColor(Color.theme.onBackground)
                        .lineLimit(1)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 2, spacing: 8)
                
                HStack(spacing: 0) {
                    Text(player.nationality)
                        .font(.theme.regular(17))
                        .foregroundColor(Color.theme.onBackground)
                        .lineLimit(1)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 8)
                
                HStack(spacing: 0) {
                    Text("\(player.age) \(Locale.get("YO"))")
                        .font(.theme.regular(17))
                        .foregroundColor(Color.theme.onBackground)
                        .lineLimit(1)
                        .containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 0)
                    Spacer()
                }.containerRelativeFrame(.horizontal, count: 4, span: 1, spacing: 8)
                
                
            }
            Divider()
                .background(Color.theme.primary)
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    let player = MockUIData.getTeamInfo().squad.first?.squad.first
    SquadItem(player: player!).loadCustomFonts()
}
