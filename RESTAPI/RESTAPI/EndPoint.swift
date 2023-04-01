//
//  EndPoint.swift
//  RESTAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public struct EndPoint {
    var method: HTTPMethod
    var url: String
    var pathComponents: [String]?
    var queryItems: [URLQueryItem]?
    var headers: [String: String]?
    var requestBody: [String: Any]?
    var boundary: String?
    
    public init(
        method: HTTPMethod,
        url: String,
        pathComponents: [String]? = nil,
        queryItems: [URLQueryItem]? = nil,
        headers: [String : String]? = nil,
        requestBody: [String : Any]? = nil,
        boundary: String? = nil) {
            
            self.method = method
            self.url = url
            self.pathComponents = pathComponents
            self.queryItems = queryItems
            self.headers = headers
            self.requestBody = requestBody
            self.boundary = boundary
        }
}
