//
//  HTTPNetworkError.swift
//  RESTAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public enum HTTPNetworkError: Error {
    case invalidURL
    case invalidResponse
    case bodyRequired
    case boundaryRequired
}
