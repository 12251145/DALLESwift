//
//  DALLEVariationImageRequest.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/31.
//

import Foundation
import RESTAPI
import UIKit

public struct DALLEVariationImageRequest {
    private var image: FormData
    private var n: Int
    private var size: ImageSize
    private var apiKey: String
    private(set) var pathComponents = ["v1", "images", "variations"]
    private(set) var headers: [String: String]
    private(set) var boundary = UUID().uuidString
    
    public init(image: FormData, n: Int, size: ImageSize, apiKey: String) {

        self.image = image
        self.n = n
        self.size = size
        self.apiKey = apiKey
        self.headers = [
            "Authorization": "Bearer \(apiKey)",
            "Content-Type": "multipart/form-data; boundary=\(boundary)"
        ]
    }

    var body: [String: Any] {
        return [
            "image": image,
            "n": n,
            "size": size.string,
            "response_format": "b64_json"
        ]
    }
}
