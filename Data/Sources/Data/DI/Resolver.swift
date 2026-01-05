//
//  Resolver.swift
//  Data
//
//  Created by Александр Мельников on 04.01.2026.
//
import Foundation
import Swinject
import Utils
import RealmSwift
import Domain

extension ResolverApp {
    public static func injectDataSources() {
        
        shared.container.register(Realm.self) { _ in
            do {
                let config = Realm.Configuration(schemaVersion: 1, deleteRealmIfMigrationNeeded: true)
                return try Realm(configuration: config)
            } catch {
                fatalError("Realm init error: \(error)")
            }
        }.inObjectScope(.container)
        
        shared.container.register(FootballNetworkService.self) { _ in
            FootballNetworkServiceImpl()
        }.inObjectScope(.container)
        
        shared.container.register(ErrorsHandler.self) { _ in
            ErrorsHandlerImpl()
        }.inObjectScope(.container)
        
        shared.container.register(CompetitionsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return CompetitionsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        shared.container.register(StandingsLocalManager.self) { resolver in
            let realm = resolver.resolve(Realm.self)!
            return StandingsLocalManagerImpl(realm: realm)
        }.inObjectScope(.container)
        
        shared.container.register(CompetitionsRepository.self) { resolver in
            let networkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let competitionsLocalManager = resolver.resolve(CompetitionsLocalManager.self)!
            return CompetitionsRepositoryImpl(
                networkService: networkService,
                errorHandler: errorHandler,
                competitionsLocalManager: competitionsLocalManager
            )
        }.inObjectScope(.container)
        
        shared.container.register(StandingsRepository.self) { resolver in
            let networkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let standingsLocalManager = resolver.resolve(StandingsLocalManager.self)!
            return StandingsRepositoryImpl(
                networkService: networkService, errorHandler: errorHandler, standingsLocalManager: standingsLocalManager
            )
        }.inObjectScope(.container)
    }
}
