//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Domain
import Utils
import Alamofire

public final class FootballRepositoryImpl: FootballRepository {
    
    private let networkService: FootballNetworkService
    private let errorHandler: ErrorsHandler
    
    public init(networkService: FootballNetworkService, errorHandler: ErrorsHandler) {
        self.networkService = networkService
        self.errorHandler = errorHandler
    }
    
    public func getAllCompetitionsFromRemoteToLocal() async -> Resource<[Competition]> {
        return await errorHandler.executeSafely {
            let response: CompetitionModelDTO = try await self.networkService.performRequest(
                "competitions/",
                method: .get,
                parameters: nil,
                encoding: URLEncoding.default
            )
            let competitions = response.competitions?.compactMap { dto in
                convertToDomain(dto)
            } ?? []
            return .success(competitions)
        }
    }
}
