//
//  ScorersBottomItem.swift
//  Presentation
//
//  Created by Александр Мельников on 17.01.2026.
//

import SwiftUI
import Utils

struct ScorersBottomItem: View {
    
    private let itemsRow = [Locale.get("G"), Locale.get("A"), Locale.get("Pen"), Locale.get("M")]
    
    var body: some View {
        let text = itemsRow.enumerated().map { index, item in
            let secondPart: String
            switch index {
            case 0: secondPart = " - \(Locale.get("Goals")), "
            case 1: secondPart = " - \(Locale.get("Assists")), "
            case 2: secondPart = " - \(Locale.get("Penalties")), "
            case 3: secondPart = " - \(Locale.get("Matches"))."
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
    ScorersBottomItem()
}
