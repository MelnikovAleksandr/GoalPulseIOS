//
//  NewsRepository.swift
//  Data
//
//  Created by Александр Мельников on 07.02.2026.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class NewsRepositoryImpl: NewsRepository {
    
    private let networkService: NetworkService
    private let errorHandler: ErrorsHandler
    private let teamsLocalManager: TeamsLocalManager
    
    public init(networkService: NetworkService, errorHandler: ErrorsHandler, teamsLocalManager: TeamsLocalManager) {
        self.networkService = networkService
        self.errorHandler = errorHandler
        self.teamsLocalManager = teamsLocalManager
    }
    
    public func getNews(teamName: String) async -> Resource<[Article]> {
        return await errorHandler.executeSafely {
            
            let parameters: Parameters = ["q": "football AND (\(teamName))","pageSize": 20,"sortBy": "publishedAt"]
            let response: NewsDTO = try await self.networkService.performRequest(EndPoints.news.rawValue, method: .get, parameters: parameters, encoding: URLEncoding.default)
            
            let articles = response.articles?.compactMap {
                $0.toDomain()
            } ?? []
            
            return .success(articles)
        }
    }
    
}
