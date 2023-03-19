//
//  EndPoint.swift
//  RESTAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

struct EndPoint {
    var method: String
    var url: String
    var pathComponents: [String]? = nil
    var queryItems: [URLQueryItem]? = nil
    var headers: [String: String]? = nil
    var requestBody: [String: Any]? = nil
}
