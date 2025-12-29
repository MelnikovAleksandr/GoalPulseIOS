//
//  StandingsRepository.swift
//  Data
//
//  Created by Александр Мельников on 27.12.2025.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class StandingsRepositoryImpl: StandingsRepository {
    
    private let networkService: FootballNetworkService
    private let errorHandler: ErrorsHandler
    private let standingsLocalManager: StandingsLocalManager
    
    public init(networkService: FootballNetworkService, errorHandler: ErrorsHandler, standingsLocalManager: StandingsLocalManager) {
        self.networkService = networkService
        self.errorHandler = errorHandler
        self.standingsLocalManager = standingsLocalManager
    }
    
    public func getStandingsFromRemoteToLocal(compCode: String) async -> Utils.Resource<Bool> {
        return await errorHandler.executeSafely {
            let response: StandingsDTO = try await self.networkService.performRequest(EndPoints.standings(compCode).rawValue, method: .get, parameters: nil, encoding: URLEncoding.default)
            
            let standingsEntity = StandingsEntity.from(dto: response)
            
            guard let standingsEntity = standingsEntity else {
                return .success(true)
            }

            try await self.standingsLocalManager.saveStandings(standingsEntity)
            
            return .success(true)
        }
    }
    
    public func getStandingsByIdFromLocal(compCode: String) -> AsyncStream<Domain.Standings> {
        return standingsLocalManager.getStandingsByIdFlow(compCode: compCode)
    }
    
}
