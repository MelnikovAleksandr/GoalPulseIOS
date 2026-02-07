//
//  FootballNetworkService.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Alamofire

public enum NetworkType: String {
    case football
    case news
}

public protocol NetworkService: Sendable {
    func performRequest<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding
    ) async throws -> T
}

public final class NetworkServiceImpl: NetworkService {
    private let baseURL: String
    private let keyName: String
    private let decoder: JSONDecoder
    private let session: Session
    private let interceptor: RequestInterceptor
    
    public init(type: NetworkType) {
        switch type {
        case .football:
            keyName = "FOOTBALL_DATA_API_KEY"
            baseURL = "https://api.football-data.org/v4/"
        case .news:
            keyName = "NEWS_DATA_API_KEY"
            baseURL = "https://newsapi.org/v2/"
        }
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            fatalError("Could not read API Key from Info.plist")
        }

        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        switch type {
        case .football:
            interceptor = FootballRequestInterceptor(apiKey: key)
        case .news:
            interceptor = NewsRequestInterceptor(apiKey: key)
        }
        session = Session(configuration: configuration, interceptor: interceptor)
    }
    
    public func performRequest<T: Decodable & Sendable>(
        _ endpoint: String,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default
    ) async throws -> T {
        let url = baseURL + endpoint
        
        let response = await session.request(url, method: method, parameters: parameters, encoding: encoding)
            .validate()
            .serializingDecodable(T.self, decoder: decoder)
            .response
        
        #if DEBUG
        if let data = response.data,
           let json = String(data: data, encoding: .utf8) {
            debugPrint(json)
        }
        #endif
        
        switch response.result {
        case .success(let decodedData):
            return decodedData
        case .failure(let error):
            var errorMessage = ""
            if let data = response.data {
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let message = json["message"] as? String {
                    errorMessage = message
                }
            }
            if errorMessage.isEmpty {
                throw error
            } else {
                throw NSError(
                    domain: "NetworkError",
                    code: error.responseCode ?? 0,
                    userInfo: [
                        NSLocalizedDescriptionKey: errorMessage,
                        "originalAFError": error
                    ]
                )
            }
        }
    }
}

final class FootballRequestInterceptor: RequestInterceptor {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.headers.add(name: "X-Auth-Token", value: apiKey)
        request.headers.add(name: "Content-Type", value: "application/json")
        completion(.success(request))
    }
}

final class NewsRequestInterceptor: RequestInterceptor {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        request.headers.add(name: "X-Api-Key", value: apiKey)
        request.headers.add(name: "Content-Type", value: "application/json")
        completion(.success(request))
    }
}
