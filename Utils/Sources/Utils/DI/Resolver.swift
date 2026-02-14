//
//  Resolver.swift
//  Utils
//
//  Created by Александр Мельников on 04.01.2026.
//
import Foundation
import Swinject

@MainActor
public final class ResolverApp {
    
    private init() {}
    
    public static let shared = ResolverApp()
    
    public var container = Container()
    
    public func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
    
    public func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        return container.resolve(T.self, argument: argument)!
    }
    
}

extension ResolverApp {
    public static func injectUtils() {
        shared.container.register(NavigationManager.self) { _ in
            NavigationManagerImpl()
        }.inObjectScope(.container)
    }
}
