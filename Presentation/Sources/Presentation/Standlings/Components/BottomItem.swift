//
//  BottomItem.swift
//  Presentation
//
//  Created by Александр Мельников on 05.01.2026.
//

import SwiftUI
import Utils

struct BottomItem: View {
    private let itemsRow = [Locale.get("M"), Locale.get("W"), Locale.get("D"), Locale.get("L"), Locale.get("GF"), Locale.get("GA"), Locale.get("P")]
    var body: some View {
        let text = itemsRow.enumerated().map { index, item in
                    let secondPart: String
                    switch index {
                    case 0: secondPart = " - \(Locale.get("Matches")), "
                    case 1: secondPart = " - \(Locale.get("Wins")), "
                    case 2: secondPart = " - \(Locale.get("Draws")), "
                    case 3: secondPart = " - \(Locale.get("Loses")), "
                    case 4: secondPart = " - \(Locale.get("GoalsFor")), "
                    case 5: secondPart = " - \(Locale.get("GoalsAgainst")), "
                    case 6: secondPart = " - \(Locale.get("Points"))."
                    default: secondPart = ""
                    }
                    return "\(item)\(secondPart)"
                }.joined(separator: " ")
        Text(text)
        .font(.theme.regular(14))
        .foregroundColor(Color.theme.onBackground)
    }
}

#Preview {
    BottomItem()
}
