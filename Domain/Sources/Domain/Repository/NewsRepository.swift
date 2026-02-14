//
//  NewsRepository.swift
//  Domain
//
//  Created by Александр Мельников on 07.02.2026.
//

import Foundation
import Utils

public protocol NewsRepository: Sendable {
    
    func getNews(teamName: String) async -> Resource<[Article]>
    
}
