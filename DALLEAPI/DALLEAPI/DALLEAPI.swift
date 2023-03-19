//
//  DALLEAPI.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

import RESTAPI

public final class DALLEAPI {
    private let baseURL = "https://api.openai.com"
    private let httpNetwork: HTTPNetworkProtocol
    
    init(httpNetwork: HTTPNetworkProtocol) {
        self.httpNetwork = httpNetwork
    }
    
    public func createImage(_ request: DALLECreateImageRequest) async throws -> [ResponseFormat] {
        let response: DALLECreateImageResponse = try await httpNetwork.request(
            endPoint: .init(
                method: .post,
                url: baseURL,
                pathComponents: request.pathComponents,
                headers: request.headers,
                requestBody: request.body
            )
        )
        
        return response.data
    }
}
