//
//  PhotoRepositoryImpl.swift
//  PhotoRepository
//
//  Created by Hoen on 2023/03/24.
//

import BaseDependencyDomain
import Photos
import PhotoManager
import UIKit

public struct PhotoRepositoryImpl: PhotoRepository {
    private let photoManager: PhotoManager
    
    public init(photoManager: PhotoManager) {
        self.photoManager = photoManager
    }
    
    public func requestImage(with asset: PHAsset?, targetSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        photoManager.requestImage(with: asset, targetSize: targetSize, completion: completion)
    }
}
