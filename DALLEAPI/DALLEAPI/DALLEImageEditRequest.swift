//
//  DALLEImageEditRequest.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/04/04.
//

import Foundation

public struct DALLEImageEditRequest {
    private var prompt: String
    private var image: FormData
    private var n: Int
    private var size: ImageSize
    private var apiKey: String
    private(set) var pathComponents = ["v1", "images", "edits"]
    private(set) var headers: [String: String]
    private(set) var boundary = UUID().uuidString
    
    public init(prompt: String, image: FormData, n: Int, size: ImageSize, apiKey: String) {

        self.prompt = prompt
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
            "prompt": prompt,
            "n": n,
            "size": size.string,
            "response_format": "b64_json"
        ]
    }
}
