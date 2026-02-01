//
//  TeamRepository.swift
//  Data
//
//  Created by Александр Мельников on 01.02.2026.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class TeamRepositoryImpl: TeamRepository {
    
    private let networkService: FootballNetworkService
    private let errorHandler: ErrorsHandler
    private let teamsLocalManager: TeamsLocalManager
    
    public init(networkService: FootballNetworkService, errorHandler: ErrorsHandler, teamsLocalManager: TeamsLocalManager) {
        self.networkService = networkService
        self.errorHandler = errorHandler
        self.teamsLocalManager = teamsLocalManager
    }
    
    
    public func getTeamFromRemoteToLocal(teamId: Int) async -> Resource<Bool> {
        return await errorHandler.executeSafely {
            let response: TeamDTO = try await self.networkService.performRequest(EndPoints.teams(String(teamId)).rawValue, method: .get, parameters: nil, encoding: URLEncoding.default)
            
            let teamInfoEntity = TeamInfoEntity.from(dto: response)
            
            guard let teamInfoEntity = teamInfoEntity else {
                return .success(true)
            }
            
            try await self.teamsLocalManager.saveTeam(teamInfoEntity)
            
            return .success(true)
        }
    }
    
    public func getTeamInfoFromLocalFlow(teamId: Int) -> AsyncStream<TeamInfo> {
        return teamsLocalManager.getTeamFlow(teamId: teamId)
    }
}
