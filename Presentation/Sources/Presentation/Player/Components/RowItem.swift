//
//  RowItem.swift
//  Presentation
//
//  Created by Александр Мельников on 14.02.2026.
//

import SwiftUI
import Utils

struct RowItem: View {
    
    let rowTitile: String
    let rowData: String
    
    var body: some View {
        HStack(spacing: 0) {
            Text(rowTitile)
                .font(.theme.bold(18))
                .foregroundColor(Color.theme.primary)
                .lineLimit(1)
            Spacer()
            Text(rowData)
                .font(.theme.mediumItalic(18))
                .foregroundColor(Color.theme.secondary)
                .lineLimit(1)
        }
        .padding(12)
        .modifier(ConditionalGlassModifier())
    }
}

#Preview {
    RowItem(rowTitile: "Name", rowData: "Bryan Mbeumo").loadCustomFonts()
}
