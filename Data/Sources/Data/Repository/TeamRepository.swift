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
    
    private let networkService: NetworkService
    private let errorHandler: ErrorsHandler
    private let teamsLocalManager: TeamsLocalManager
    private let standingsLocalManager: StandingsLocalManager
    
    public init(networkService: NetworkService, errorHandler: ErrorsHandler, teamsLocalManager: TeamsLocalManager, standingsLocalManager: StandingsLocalManager) {
        self.networkService = networkService
        self.errorHandler = errorHandler
        self.teamsLocalManager = teamsLocalManager
        self.standingsLocalManager = standingsLocalManager
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
    
    public func getMatchesFromRemoteToLocal(teamId: Int) async -> Resource<Bool> {
        return await errorHandler.executeSafely {
            let response: MatchesDTO = try await self.networkService.performRequest(EndPoints.teamsMatches("\(teamId)").rawValue, method: .get, parameters: nil, encoding: URLEncoding.default)
            
            let matchesEntity = MatchesEntity.fromTeam(dto: response, teamId: teamId)
            
            guard let matchesEntity = matchesEntity else {
                return .success(true)
            }
            
            try await self.standingsLocalManager.saveMatches(matchesEntity)
            
            return .success(true)
        }
    }
    
    public func getAheadMatchesFromLocalFlow(teamId: Int) -> AsyncStream<[MatchesByTour]> {
        return standingsLocalManager.getAheadMatchesByCompCodeFlow(compCode: "\(teamId)")
    }
    
    public func getCompletedMatchesFromLocalFlow(teamId: Int) -> AsyncStream<[MatchesByTour]> {
        return standingsLocalManager.getCompletedMatchesByCompCodeFlow(compCode: "\(teamId)")
    }
}
