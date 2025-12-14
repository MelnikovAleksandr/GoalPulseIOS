//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Utils
import Alamofire

public protocol ErrorsHandler: Sendable {
    func executeSafely<T>(_ block: () async throws -> Resource<T>) async -> Resource<T>
}

public final class ErrorsHandlerImpl: ErrorsHandler {
    
    public init() {}
    
    public func executeSafely<T>(_ block: () async throws -> Resource<T>) async -> Resource<T> {
        do {
            return try await block()
        } catch let error as URLError where error.code == .timedOut {
            return .error(.timeout(message: error.localizedDescription), nil)
        } catch let error as URLError where error.code == .notConnectedToInternet {
            return .error(.missingConnection(message: error.localizedDescription), nil)
        } catch let error as AFError {
            return handleAFError(error)
        } catch {
            return .error(.unknown(message: error.localizedDescription), nil)
        }
    }
    
    private func handleAFError<T>(_ error: AFError) -> Resource<T> {
        guard let responseCode = error.responseCode else {
            return .error(.unknown(message: error.localizedDescription), nil)
        }
        
        switch responseCode {
        case 400...499:
            return .error(.https400(errorCode: responseCode, message: error.localizedDescription), nil)
        case 500...599:
            return .error(.https500(errorCode: responseCode, message: error.localizedDescription), nil)
        default:
            return .error(.unknown(message: error.localizedDescription), nil)
        }
    }
}
