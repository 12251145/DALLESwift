//
//  ResponseFormat.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public struct ResponseFormat: Decodable {
    public var base64Json: String
    
    enum CodingKeys: String, CodingKey {
        case base64Json = "b64_json"
    }
}
