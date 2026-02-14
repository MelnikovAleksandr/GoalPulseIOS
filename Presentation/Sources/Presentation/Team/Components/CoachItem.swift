//
//  CoachItem.swift
//  Presentation
//
//  Created by Александр Мельников on 07.02.2026.
//

import SwiftUI
import Domain
import Utils

struct CoachItem: View {
    
    let player: Person
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(Locale.get("Manager"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                Text(Locale.get("Contract until"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
            }
            Divider()
                .background(Color.theme.primary)
            HStack(spacing: 0) {
                Text(player.name)
                    .padding(8)
                    .font(.theme.italic(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                Text(player.contractUntilYear)
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    CoachItem(player: MockUIData.getTeamInfo().coach).loadCustomFonts()
}
