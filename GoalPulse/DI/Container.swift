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
    
    func injectModules() {
        FontsHelper.resigterFonts()
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
        
        container.register(CompetitionsLocalManager.self) { _ in
            CompetitionsLocalManagerImpl()
        }.inObjectScope(.container)
        
        container.register(CompetitionsRepository.self) { resolver in
            let networkService = resolver.resolve(FootballNetworkService.self)!
            let errorHandler = resolver.resolve(ErrorsHandler.self)!
            let competitionsLocalManager = resolver.resolve(CompetitionsLocalManager.self)!
            return CompetitionsRepositoryImpl(
                networkService: networkService,
                errorHandler: errorHandler,
                competitionsLocalManager: competitionsLocalManager
            )
        }.inObjectScope(.container)
    }
}

extension Resolver {
    
    private func injectViewModels() {
        container.register(CompetitionsViewModel.self) { resolver in
            let repository = resolver.resolve(CompetitionsRepository.self)!
            return CompetitionsViewModel(repository: repository)
        }
    }
}

