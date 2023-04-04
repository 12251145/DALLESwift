//
//  PhotoRepository.swift
//  BaseDependencyDomain
//
//  Created by Hoen on 2023/03/27.
//

import Photos
import UIKit

public protocol PhotoRepository {
    func requestImage(with asset: PHAsset?, targetSize: CGSize, fetchDegradedAlso: Bool, completion: @escaping (UIImage?) -> Void)
}
