//
//  ScoreItem.swift
//  Presentation
//
//  Created by Александр Мельников on 29.01.2026.
//

import SwiftUI

struct ScoreItem: View {
    let homeScore: Int
    let awayScore: Int
    
    var body: some View {
        Text("\(homeScore) - \(awayScore)")
            .foregroundColor(Color.theme.onBackground)
            .font(.theme.regular(22))
            .padding(10)
            .background(Color.theme.primary)
            .cornerRadius(8)
    }
}

#Preview {
    ScoreItem(homeScore: 2, awayScore: 1)
}


