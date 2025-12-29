//
//  CompetitionsRepositoryImpl.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class CompetitionsRepositoryImpl: CompetitionsRepository {
    
    private let networkService: FootballNetworkService
    private let errorHandler: ErrorsHandler
    private let competitionsLocalManager: CompetitionsLocalManager
    
    public init(networkService: FootballNetworkService, errorHandler: ErrorsHandler, competitionsLocalManager: CompetitionsLocalManager) {
        self.networkService = networkService
        self.errorHandler = errorHandler
        self.competitionsLocalManager = competitionsLocalManager
    }
    
    public func getAllCompetitionsFromRemoteToLocal() async -> Resource<Bool> {
        return await errorHandler.executeSafely {
            let response: CompetitionModelDTO = try await self.networkService.performRequest(
                EndPoints.competitions.rawValue,
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default
            )
            
            let competitionsEntities = response.competitions?.compactMap { dto in
                CompetitionEntity.from(dto: dto)
            } ?? []

            try await self.competitionsLocalManager.saveCompetitions(competitionsEntities)
        
            return .success(true)
        }
    }
    
    public func getAllCompetitionsFromLocal() -> AsyncStream<[Competition]> {
            return competitionsLocalManager.getAllCompetitionsFlow()
        }
    
}
