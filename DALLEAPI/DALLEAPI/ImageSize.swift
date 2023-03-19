//
//  ImageSize.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

enum ImageSize {
    case low
    case mid
    case high
    
    var string: String {
        switch self {
        case .low:
            return "256x256"
        case .mid:
            return "512x512"
        case .high:
            return "1024x1024"
        }
    }
}
