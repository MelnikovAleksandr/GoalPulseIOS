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
    
    public func getAllCompetitionsFromRemoteToLocal() async -> Resource<[Competition]> {
        return await errorHandler.executeSafely {
            let response: CompetitionModelDTO = try await self.networkService.performRequest(
                "competitions/",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default
            )
            guard let competitionsDTO = response.competitions else {
                return .success([])
            }
            
            try await self.competitionsLocalManager.saveCompetitions(competitionsDTO)
            
            let competitions = competitionsDTO.compactMap { dto in
                convertToDomain(dto)
            }
            
            return .success(competitions)
        }
    }
    
    public func getAllCompetitionsFromLocal() -> AsyncStream<[Competition]> {
            return competitionsLocalManager.getAllCompetitionsFlow()
        }
    
}
