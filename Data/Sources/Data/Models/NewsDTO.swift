//
//  NewsDTO.swift
//  Data
//
//  Created by Александр Мельников on 07.02.2026.
//

import Foundation

struct NewsDTO: Codable {
    let articles: [ArticleDTO]?
    
    enum CodingKeys: String, CodingKey {
        case articles = "articles"
    }
}

struct ArticleDTO: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}

