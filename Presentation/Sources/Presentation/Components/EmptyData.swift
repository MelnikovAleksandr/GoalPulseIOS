//
//  EmptyData.swift
//  Presentation
//
//  Created by Александр Мельников on 08.02.2026.
//

import SwiftUI
import Utils

struct EmptyData: View {
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "shippingbox.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color.theme.primary)
                
                Text(Locale.get("EmptyData"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
                    .foregroundColor(Color.theme.primary)
                    .font(.theme.medium(24))
            }
        }
        .padding(.vertical, 80)
        .frame(width: UIScreen.main.bounds.width)
    }
}

#Preview {
    EmptyData().loadCustomFonts()
}
