//
//  DALLECreateImageRequest.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

import Foundation

public struct DALLECreateImageRequest {
    private var prompt: String
    private var n: Int
    private var size: ImageSize
    private var apiKey: String
    private(set) var pathComponents = ["v1", "images", "generatioins"]
    private(set) var headers: [String: String]
    
    init(prompt: String, n: Int, size: ImageSize, apiKey: String) {
        self.prompt = prompt
        self.n = n
        self.size = size
        self.apiKey = apiKey
        self.headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
    }

    var body: [String: Any] {
        return [
            "prompt": prompt,
            "n": n,
            "size": size.string,
            "response_format": "b64_json"
        ]
    }
}
