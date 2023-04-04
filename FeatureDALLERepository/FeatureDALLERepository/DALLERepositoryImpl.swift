//
//  DALLERepositoryImpl.swift
//  FeatureDALLERepository
//
//  Created by Hoen on 2023/03/19.
//

import DALLEAPI
import FeatureDALLEDomain
import Util
import UIKit

public struct DALLERepositoryImpl: DALLERepository {
    
    private enum RequestKind {
        case promptOnly(prompt: String)
        case variation(data: FormData)
        case edit
        case unknown
    }
    
    private let dallEApi: DALLEAPI
    private let apiKey: String = "apiKey"
    public init(dallEApi: DALLEAPI) {
        self.dallEApi = dallEApi
    }
    
    public func requestGenerateImage(
        prompt: String?,
        n: Int,
        pngData: Data,
        masked: Bool
    ) async throws -> [UIImage] {
        
        let image = FormData(data: pngData, mimeType: "png", fileName: "image")
        
        let requestKind = requestKind(prompt: prompt, image: image, masked: masked)
        var images: [UIImage] = []
        
        switch requestKind {
        case .promptOnly(let prompt):
            images = try await requestPromptOnly(prompt)
        case .variation(let data):
            images = try await requestVariation(data)
        case .edit:
            break
        case .unknown:
            break
        }

        return images
    }
    
    private func requestKind(prompt: String?, image: FormData?, masked: Bool) -> RequestKind {
        if let prompt, image == nil, !masked {
            return .promptOnly(prompt: prompt)
        }
        
        if let image, !prompt.notNilNotEmpty(), !masked {
            return .variation(data: image)
        }
        
        if prompt != nil && image != nil && masked {
            return .edit
        }
        
        return .unknown
    }
    
    private func requestPromptOnly(_ prompt: String) async throws -> [UIImage] {
        var images: [UIImage?] = []
        let result = try await dallEApi.createImage(
            .init(
                prompt: prompt,
                n: 1,
                size: .high,
                apiKey: apiKey
            )
        )
        
        result.forEach { format in
            let base64String = format.base64Json
            if let imageData = Data(base64Encoded: base64String) {
                images.append(UIImage(data: imageData))
            } else {
                print("Base64 decoding failed!")
            }
        }
        
        return images.compactMap { $0 }
    }
    
    private func requestVariation(_ data: FormData) async throws -> [UIImage] {
        var images: [UIImage?] = []
        
        let result = try await dallEApi.variationImage(
            .init(
                image: data,
                n: 1,
                size: .high,
                apiKey: apiKey
            )
        )

        result.forEach { format in
            let base64String = format.base64Json
            if let imageData = Data(base64Encoded: base64String) {
                images.append(UIImage(data: imageData))
            } else {
                print("Base64 decoding failed!")
            }
        }
        
        return images.compactMap { $0 }
    }
}
