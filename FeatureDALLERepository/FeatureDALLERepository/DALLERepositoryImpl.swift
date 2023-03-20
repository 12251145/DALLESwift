//
//  DALLERepositoryImpl.swift
//  FeatureDALLERepository
//
//  Created by Hoen on 2023/03/19.
//

import DALLEAPI
import FeatureDALLEDomain
import UIKit

public struct DALLERepositoryImpl: DALLERepository {
    
    private let dallEApi: DALLEAPI
    
    public init(dallEApi: DALLEAPI) {
        self.dallEApi = dallEApi
    }
    
    public func requestGenerateImage() async throws -> UIImage? {

        let result = try await dallEApi.createImage(
            .init(
                prompt: "rainy city 3d rendering",
                n: 1,
                size: .high,
                apiKey: "apiKey"
            )
        )
        var image: UIImage?
        result.forEach { format in
            let base64String = format.base64Json
            if let imageData = Data(base64Encoded: base64String) {
                image = UIImage(data: imageData)
            } else {
                print("Base64 decoding failed!")
            }
        }
        
        return image
    }
}
