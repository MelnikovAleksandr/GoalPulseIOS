//
//  Container.swift
//  GoalPulse
//
//  Created by Александр Мельников on 06.12.2025.
//

import Foundation
import Swinject
import Utils
import Data
import Domain
import Presentation

class Resolver {
    
    static let shared = Resolver()
    
    private var container = Container()

    @MainActor func injectModules() {
        injectUtils()
        injectDataSources()
        injectViewModels()
    }

    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}

extension Resolver {
    private func injectUtils() {
        container.register(NavigationManager.self) { _ in
            NavigationManagerImpl()
        }.inObjectScope(.container)
    }
}

extension Resolver {
    private func injectDataSources() {
        container.register(FootballNetworkService.self) { _ in
            FootballNetworkServiceImpl()
        }.inObjectScope(.container)
        
        container.register(ErrorsHandler.self) { _ in
            ErrorsHandlerImpl()
        }.inObjectScope(.container)
        
        container.register(FootballRepository.self) { resolver in
            let networkService: FootballNetworkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler: ErrorsHandler = resolver.resolve(ErrorsHandler.self)!
            return FootballRepositoryImpl(
                networkService: networkService,
                errorHandler: errorHandler
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    
    @MainActor
    private func injectViewModels() {
        container.register(CompetitionsViewModel.self) { resolver in
            let repository = resolver.resolve(FootballRepository.self)!
            return CompetitionsViewModel(repository: repository)
        }
    }
}

