//
//  ErrorsTypesHttp.swift
//  Utils
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation

public enum ErrorsTypesHttp {
    case https400(errorCode: Int?, message: String?)
    case https500(errorCode: Int?, message: String?)
    case timeout(message: String?)
    case missingConnection(message: String?)
    case networkError(message: String?)
    case unknown(message: String?)
    
    var code: Int? {
        switch self {
        case .https400(let errorCode, _): return errorCode
        case .https500(let errorCode, _): return errorCode
        default: return nil
        }
    }
    
    public var errorMessage: String? {
        switch self {
        case .https400(_, let message): return message
        case .https500(_, let message): return message
        case .timeout(let message): return message
        case .missingConnection(let message): return message
        case .networkError(let message): return message
        case .unknown(let message): return message
        }
    }
}
