//
//  News.swift
//  Domain
//
//  Created by Александр Мельников on 07.02.2026.
//

import Foundation

public struct Article: Identifiable, Sendable {
    public var id: String { author + title }
    public let author: String
    public let title: String
    public let description: String
    public let url: URL?
    public let urlToImage: URL?
    public let publishedAt: Date
    public let content: String
    
    public init(author: String, title: String, description: String, url: URL?, urlToImage: URL?, publishedAt: Date, content: String) {
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
}
