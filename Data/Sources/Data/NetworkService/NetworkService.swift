//
//  File.swift
//  Data
//
//  Created by Александр Мельников on 13.12.2025.
//

import Foundation
import Alamofire

public protocol FootballNetworkService: Sendable {
    func performRequest<T: Decodable>(
        _ endpoint: String,
        method: HTTPMethod,
        parameters: Parameters?,
        encoding: ParameterEncoding
    ) async throws -> T
}

public final class FootballNetworkServiceImpl: FootballNetworkService {
    private let baseURL = "https://api.football-data.org/v4/"
    private let apiKey = ""
    private let decoder: JSONDecoder
    private let session: Session
    
    public init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        
        let interceptor = FootballRequestInterceptor(apiKey: apiKey)
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
        debugPrint(response)
        #endif
        
        switch response.result {
        case .success(let decodedData):
            return decodedData
        case .failure(let error):
            throw error
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
