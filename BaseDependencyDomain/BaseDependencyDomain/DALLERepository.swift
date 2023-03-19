//
//  DALLERepository.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/03/19.
//

import UIKit

public protocol DALLERepository {
    func requestGenerateImage() async -> UIImage?
}
