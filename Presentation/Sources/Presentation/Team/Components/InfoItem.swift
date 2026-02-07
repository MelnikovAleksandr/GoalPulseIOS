//
//  InfoItem.swift
//  Presentation
//
//  Created by Александр Мельников on 07.02.2026.
//

import SwiftUI
import Domain
import Utils

struct InfoItem: View {
    
    let team: TeamInfo
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                Text(Locale.get("Area"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                AsyncMultiImage(url: team.area.flag)
                    .padding(8)
                    .frame(width: 34, height: 34)
            }
            HStack(spacing: 0) {
                Text(Locale.get("Founded"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                Text("\(team.founded)")
                    .padding(8)
                    .font(.theme.italic(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
            }
            HStack(spacing: 0) {
                Text(Locale.get("Venue"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                Text(team.venue)
                    .padding(8)
                    .font(.theme.italic(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
            }
            HStack(spacing: 0) {
                Text(Locale.get("Address"))
                    .padding(8)
                    .font(.theme.medium(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(1)
                Spacer()
                Text(team.address)
                    .multilineTextAlignment(.trailing)
                    .padding(8)
                    .font(.theme.italic(17))
                    .foregroundColor(Color.theme.onBackground)
                    .lineLimit(2)
            }
            HStack(spacing: 0) {
                if let url = team.website {
                    Link("\(url)", destination: url)
                        .font(.theme.bold(17))
                        .padding(8)
                }
                Spacer()
            }
            
            Divider()
                .background(Color.theme.primary)
        }
        .frame(maxWidth: .infinity)
        .background(Color.clear)
    }
}

#Preview {
    InfoItem(team: MockUIData.getTeamInfo()).loadCustomFonts()
}


