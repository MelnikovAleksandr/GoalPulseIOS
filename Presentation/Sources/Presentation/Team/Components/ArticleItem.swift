//
//  ArticleItem.swift
//  Presentation
//
//  Created by Александр Мельников on 07.02.2026.
//

import SwiftUI
import Domain
import Utils

struct ArticleItem: View {
    
    let article: Article
    
    var body: some View {
        HStack(spacing: 0) {
            
            AsyncMultiImage(
                url: article.urlToImage
            )
            .scaledToFill()
            .frame(width: 120, height: 80)
            .clipped()
            .containerRelativeFrame(.horizontal, count: 3, span: 1, spacing: 0)
            
            
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 0) {
                    Text(article.title)
                        .font(.theme.medium(18))
                        .padding(.vertical, 4)
                        .foregroundColor(Color.theme.onBackground)
                        .lineLimit(2)
                    
                    HStack(spacing: 0) {
                        Text(article.author)
                            .font(.theme.italic(14))
                            .padding(.vertical, 4)
                            .foregroundColor(Color.theme.onBackground)
                            .lineLimit(1)
                        Image(systemName: "clock")
                            .font(.system(size: 14))
                            .foregroundColor(Color.theme.onBackground)
                            .padding(.horizontal, 4)
                        Text(UIDateTimeFormatters.fullDate.string(from: article.publishedAt))
                            .font(.theme.italic(14))
                            .padding(.vertical, 4)
                            .foregroundColor(Color.theme.onBackground)
                            .lineLimit(1)
                    }
                    
                    
                }
                Spacer()
            }
            .containerRelativeFrame(.horizontal, count: 3, span: 2, spacing: 0)
            .padding(.horizontal, 8)
        }
        .background(Color.clear)
        .onTapGesture {
            guard let url = article.url else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }
    }
}


#Preview {
    ArticleItem(article: MockUIData.articles.first!).loadCustomFonts()
}
