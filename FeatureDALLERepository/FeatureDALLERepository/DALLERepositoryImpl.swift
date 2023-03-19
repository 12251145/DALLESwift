//
//  DALLERepositoryImpl.swift
//  FeatureDALLERepository
//
//  Created by Hoen on 2023/03/19.
//

import FeatureDALLEDomain
import UIKit

public struct DALLERepositoryImpl: DALLERepository {
    public func requestGenerateImage() async throws -> UIImage? {
        try await Task.sleep(nanoseconds: 1000000000)
        
        return UIImage()
    }
}
