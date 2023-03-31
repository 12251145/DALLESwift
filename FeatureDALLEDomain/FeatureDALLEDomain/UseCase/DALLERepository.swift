//
//  DALLERepository.swift
//  FeatureDALLEDomain
//
//  Created by Hoen on 2023/03/19.
//

import UIKit

public protocol DALLERepository {
    func requestGenerateImage(prompt: String?, n: Int, image: String?, mask: String?) async throws -> [UIImage]
}
