//
//  DALLEAPI.swift
//  DALLEAPI
//
//  Created by Hoen on 2023/03/19.
//

@_exported import RESTAPI

public final class DALLEAPI {
    private let baseURL = "https://api.openai.com"
    private let httpNetwork: HTTPNetworkProtocol
    
    public init(httpNetwork: HTTPNetworkProtocol) {
        self.httpNetwork = httpNetwork
    }
    
    public func createImage(_ request: DALLECreateImageRequest) async throws -> [ResponseFormat] {
        let response: DALLEAPIResponse = try await httpNetwork.request(
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
    
    public func variationImage(_ request: DALLEVariationImageRequest) async throws -> [ResponseFormat] {
        let response: DALLEAPIResponse = try await httpNetwork.requestWithMultiPartFormData(
            endPoint: .init(
                method: .post,
                url: baseURL,
                pathComponents: request.pathComponents,
                headers: request.headers,
                requestBody: request.body,
                boundary: request.boundary
            )
        )
        
        return response.data
    }
    
    public func editImage(_ request: DALLEImageEditRequest) async throws -> [ResponseFormat] {

        let response: DALLEAPIResponse = try await httpNetwork.requestWithMultiPartFormData(
            endPoint: .init(
                method: .post,
                url: baseURL,
                pathComponents: request.pathComponents,
                headers: request.headers,
                requestBody: request.body,
                boundary: request.boundary
            )
        )
        
        return response.data
    }
}
