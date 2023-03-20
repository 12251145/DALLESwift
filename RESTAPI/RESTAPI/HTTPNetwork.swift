//
//  HTTPNetwork.swift
//  RESTAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public protocol HTTPNetworkProtocol {
    func request<T: Decodable>(endPoint: EndPoint) async throws -> T
}

public final class HTTPNetwork: HTTPNetworkProtocol {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func request<T: Decodable>(endPoint: EndPoint) async throws -> T {
        guard var baseComponents = URLComponents(string: endPoint.url) else {
            throw HTTPNetworkError.invalidURL
        }
        
        if let pathComponents = endPoint.pathComponents {
            baseComponents.path = (baseComponents.path as NSString)
                .appendingPathComponent("/" + pathComponents.joined(separator: "/"))
        }
        
        baseComponents.queryItems = endPoint.queryItems
        
        guard let url = baseComponents.url else {
            throw HTTPNetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endPoint.method.rawValue
        request.allHTTPHeaderFields = endPoint.headers
        request.timeoutInterval = .infinity
        
        if let requestBody = endPoint.requestBody {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            } catch {
                throw error
            }
        }
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw HTTPNetworkError.invalidResponse
        }
        
        let decoded = try JSONDecoder().decode(T.self, from: data)
        return decoded
    }
}
