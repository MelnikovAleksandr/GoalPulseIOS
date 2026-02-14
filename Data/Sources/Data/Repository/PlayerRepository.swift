//
//  PlayerRepository.swift
//  Data
//
//  Created by Александр Мельников on 14.02.2026.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class PlayerRepositoryImpl: PlayerRepository {
    
    private let networkService: NetworkService
    private let errorHandler: ErrorsHandler
    
    public init(networkService: NetworkService, errorHandler: ErrorsHandler) {
        self.networkService = networkService
        self.errorHandler = errorHandler
    }
    
    
    public func getPlayerInfo(playerId: Int) async -> Resource<PersonInfo> {
        await errorHandler.executeSafely {
            let response: PersonInfoDTO = try await self.networkService.performRequest(EndPoints.persons(String(playerId)).rawValue, method: .get, parameters: nil, encoding: URLEncoding.default)
            let player = response.toDomain()
            return .success(player)
        }
    }
}
