//
//  DALLERepository.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/19.
//

import UIKit

public protocol DALLERepository {
    func requestGenerateImage(prompt: String?, n: Int, pngData: Data, mask: String?) async throws -> [UIImage]
}
